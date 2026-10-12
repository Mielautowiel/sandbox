# Projectstarter

Startpunt voor elk nieuw projectje, met drie agents die je op een ticket kunt inzetten.

## Nieuw project (één commando)

**Eenmalig** in PowerShell:
```
winget install GitHub.cli
```
Open PowerShell opnieuw, dan:
```
gh auth login
gh repo clone Mielautowiel/sandbox projectstarter
cd projectstarter
```

**Per nieuw project** (in die map `projectstarter`):
```
powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 boodschappenlijst
```
Dit maakt een privé-repo vanuit deze starter, zet het Claude-token erin, zet de Actions-rechten goed
en opent het project in VS Code. Het token wordt alleen de eerste keer gevraagd
(en bewaard in `%USERPROFILE%\.werkplaats\claude-token.txt`; deel dat bestand met niemand).

Een bestaande repo (zoals deze) alleen instellen: `... nieuw-project.ps1 sandbox -Bestaand`.

Daarna eventueel de regel **Wat:** in `CLAUDE.md` aanpassen.

## Werken met tickets
1. **Issues → New issue → Ticket** en beschrijf wat je wilt (screenshots mogen).
2. Kies rechts bij **Labels** een agent:
   | Label | Wat de agent doet |
   |---|---|
   | `agent: prototype` | klikbaar prototype in `prototype/index.html` |
   | `agent: ontwerp` | plan met takenlijst in `docs/ontwerp.md` |
   | `agent: realiseren` | bouwt het echt, met tests |
3. De agent zet een reactie op het ticket. Daarna draaien de tests; zijn ze groen, dan wordt het **automatisch gemerged**.
   Falen ze, dan wordt er niets gemerged en zie je waarom.
4. Feedback? Zet het in een reactie en kies de agent opnieuw. Klaar? Sluit het ticket.

Alleen jij (eigenaar van de repo) kunt een agent starten. De labels worden vanzelf aangemaakt bij het eerste ticket.

## In VS Code
Dezelfde agents werken in Claude Code: typ bijvoorbeeld `@agent-prototype maak een prototype voor ...`
of "gebruik de realiseren-agent voor taak 2". Tests draaien met `bash run-tests.sh`.

## Starten
```
python -m http.server 8000
```
en open http://localhost:8000 · prototype: open `prototype/index.html`.
