<#
  Nieuw project maken vanuit de projectstarter - in een keer klaar voor gebruik.

  Gebruik (in PowerShell, in de map waar dit script staat):
    powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 boodschappenlijst
    powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 sandbox -Bestaand   # alleen instellen

  Wat het doet:
    1. maakt een prive-repo vanuit de projectstarter (Mielautowiel/sandbox)
    2. zet het Claude-token erin als secret (vraagt het token alleen de eerste keer)
    3. zet de Actions-rechten goed (schrijven + pull requests maken)
    4. kloont de repo en opent hem in VS Code
#>
param(
  [Parameter(Mandatory = $true)][string]$Naam,
  [switch]$Bestaand,
  [string]$Sjabloon = "Mielautowiel/sandbox"
)

function Stop-Met($tekst) { Write-Host $tekst -ForegroundColor Red; exit 1 }

# GitHub CLI aanwezig en ingelogd?
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Stop-Met "GitHub CLI ontbreekt. Installeer met:  winget install GitHub.cli   en open daarna PowerShell opnieuw."
}
gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) { gh auth login; if ($LASTEXITCODE -ne 0) { Stop-Met "Inloggen bij GitHub mislukt." } }

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
$token = (Get-Content $bestand -Raw).Trim()

# Repo maken vanuit het sjabloon
if (-not $Bestaand) {
  gh api -X PATCH "repos/$Sjabloon" -F is_template=true 2>$null | Out-Null
  Write-Host "Repo $repo aanmaken..."
  gh repo create $repo --private --template $Sjabloon
  if ($LASTEXITCODE -ne 0) { Stop-Met "Aanmaken mislukt (bestaat '$Naam' misschien al? Gebruik dan -Bestaand)." }
  Start-Sleep -Seconds 5
}

# Secret en rechten
gh secret set CLAUDE_CODE_OAUTH_TOKEN -R $repo --body $token
if ($LASTEXITCODE -ne 0) { Stop-Met "Secret zetten mislukt." }
gh api -X PUT "repos/$repo/actions/permissions/workflow" -f default_workflow_permissions=write -F can_approve_pull_request_reviews=true | Out-Null
if ($LASTEXITCODE -ne 0) { Stop-Met "Actions-rechten zetten mislukt." }

# Klonen en openen
if (-not $Bestaand) {
  if (-not (Test-Path $Naam)) { gh repo clone $repo $Naam -- -q }
  if (Get-Command code -ErrorAction SilentlyContinue) { code $Naam }
}

Write-Host ""
Write-Host "Klaar: https://github.com/$repo" -ForegroundColor Green
Write-Host "Maak een ticket aan (Issues -> New issue) en kies een agent-label."
