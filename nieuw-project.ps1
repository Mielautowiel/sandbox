<#
  Project klaarzetten voor de ontwikkelstraat - in een keer.

  Gebruik (in PowerShell, in de map waar dit script staat):
    powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 MijnProject              # nieuw project
    powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 OpruimMaatje -Bestaand   # bestaand project instellen

  Wat het doet:
    1. (nieuw) maakt een prive-repo vanuit de projectstarter (Mielautowiel/sandbox)
    2. zet twee secrets: het Claude-token (vraagt het alleen de eerste keer) en je GitHub-token voor het bord
    3. zet de Actions-rechten goed (schrijven + pull requests maken)
    4. maakt het bord met de kolommen ToDo, Review en Feedback, Realisatie, Uitlevering, Done en de labels
    5. (nieuw) kloont de repo en opent hem in VS Code
#>
param(
  [Parameter(Mandatory = $true)][string]$Naam,
  [switch]$Bestaand,
  [string]$Sjabloon = "Mielautowiel/sandbox"
)

function Stop-Met($tekst) { Write-Host $tekst -ForegroundColor Red; exit 1 }

# GitHub CLI aanwezig, ingelogd en met rechten voor borden?
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Stop-Met "GitHub CLI ontbreekt. Installeer met:  winget install GitHub.cli   en open daarna PowerShell opnieuw."
}
gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) { gh auth login -s project,workflow; if ($LASTEXITCODE -ne 0) { Stop-Met "Inloggen bij GitHub mislukt." } }
$status = (gh auth status 2>&1 | Out-String)
if ($status -notmatch "'project'" -or $status -notmatch "'workflow'") {
  Write-Host "Eenmalig: GitHub vraagt om extra rechten voor borden en workflows (browser opent)..."
  gh auth refresh -h github.com -s project,workflow
  if ($LASTEXITCODE -ne 0) { Stop-Met "Extra rechten toekennen mislukt." }
}

$eigenaar = (gh api user --jq .login).Trim()
$repo = "$eigenaar/$Naam"

# Claude-token: eenmalig vragen en bewaren in je gebruikersmap
$map = Join-Path $env:USERPROFILE ".werkplaats"
$bestand = Join-Path $map "claude-token.txt"
if (-not (Test-Path $bestand)) {
  New-Item -ItemType Directory -Force -Path $map | Out-Null
  $invoer = Read-Host "Plak je Claude-token (begint met sk-ant-oat01-). Dit wordt eenmalig gevraagd"
  if (-not $invoer.Trim().StartsWith("sk-ant-")) { Stop-Met "Dat lijkt geen Claude-token. Maak er een met:  claude setup-token" }
  Set-Content -Path $bestand -Value $invoer.Trim() -NoNewline
}
$claudeToken = (Get-Content $bestand -Raw).Trim()
$githubToken = (gh auth token).Trim()

# Repo maken vanuit het sjabloon
if (-not $Bestaand) {
  gh api -X PATCH "repos/$Sjabloon" -F is_template=true 2>$null | Out-Null
  Write-Host "Repo $repo aanmaken..."
  gh repo create $repo --private --template $Sjabloon
  if ($LASTEXITCODE -ne 0) { Stop-Met "Aanmaken mislukt (bestaat '$Naam' misschien al? Gebruik dan -Bestaand)." }
  Start-Sleep -Seconds 5
}

# Secrets en rechten
gh secret set CLAUDE_CODE_OAUTH_TOKEN -R $repo --body $claudeToken
if ($LASTEXITCODE -ne 0) { Stop-Met "Claude-token zetten mislukt." }
gh secret set PROJECT_TOKEN -R $repo --body $githubToken
if ($LASTEXITCODE -ne 0) { Stop-Met "Bord-token zetten mislukt." }
gh api -X PUT "repos/$repo/actions/permissions/workflow" -f default_workflow_permissions=write -F can_approve_pull_request_reviews=true | Out-Null
if ($LASTEXITCODE -ne 0) { Stop-Met "Actions-rechten zetten mislukt." }

# Bord, kolommen en labels (via de workflow "Bord" in de repo)
$gestart = $false
for ($i = 0; $i -lt 6 -and -not $gestart; $i++) {
  gh workflow run bord.yml -R $repo 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) { $gestart = $true } else { Start-Sleep -Seconds 5 }
}
if ($gestart) { Write-Host "Bord wordt ingericht (Actions -> Bord). Duurt ongeveer een halve minuut." }
else { Write-Host "Kon de workflow 'Bord' niet starten; start hem zelf via Actions -> Bord -> Run workflow." -ForegroundColor Yellow }

# Klonen en openen
if (-not $Bestaand) {
  if (-not (Test-Path $Naam)) { gh repo clone $repo $Naam -- -q }
  if (Get-Command code -ErrorAction SilentlyContinue) { code $Naam }
}

Write-Host ""
Write-Host "Klaar: https://github.com/$repo" -ForegroundColor Green
Write-Host "Bord: https://github.com/$eigenaar?tab=projects  (open het bord '$Naam' en kies eenmalig Layout: Board)"
