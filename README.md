# Projectstarter

Startpunt voor elk nieuw project, met de ontwikkelstraat ingebouwd:
- **Lokaal** in VS Code met Claude: snel en in kleine stappen bouwen en meteen bekijken.
- **Via het bord** in GitHub: kleine losse tickets laten bouwen door een agent; testen en mergen gaan automatisch.

Hoe het werkt staat in [`docs/werkwijze.md`](docs/werkwijze.md).

## Nieuw project (één commando)
**Eenmalig** in PowerShell (niet als beheerder):
```
winget install GitHub.cli
winget install Git.Git
```
Open PowerShell opnieuw, dan:
```
gh auth login
gh repo clone Mielautowiel/sandbox projectstarter
```

**Per project**, in de map `projectstarter`:
```
cd $HOME\projectstarter
git pull
powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 MijnProject
```
Dit maakt een privé-repo vanuit deze starter, zet de tokens en rechten, maakt het bord met de kolommen
**ToDo · Review en Feedback · Realisatie · Uitlevering · Done** en opent het project in VS Code.
Het Claude-token wordt alleen de eerste keer gevraagd en bewaard in `%USERPROFILE%\.werkplaats\claude-token.txt`
(deel dat bestand met niemand).

Een **bestaand** project instellen of bijwerken: `... nieuw-project.ps1 OpruimMaatje -Bestaand`.

Open daarna het bord en kies één keer **Layout: Board** bij de weergave. Pas de regels **Wat:** en **Preview:** in `CLAUDE.md` aan.

Voor preview-links op je mobiel: koppel de repo aan **Cloudflare** (Workers) (zie `docs/werkwijze.md`, onderaan).

## Lokaal bekijken
```
node serve.js
```
en open http://localhost:8000. Tests: `bash run-tests.sh`.
