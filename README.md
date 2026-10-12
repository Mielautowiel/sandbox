# Projectstarter

Startpunt voor elk nieuw projectje, met drie agents die je op een ticket kunt inzetten.

## Nieuw project
1. Klik op **Use this template → Create a new repository** (privé mag).
2. In de nieuwe repo: Settings → Secrets and variables → Actions → **New repository secret**
   `CLAUDE_CODE_OAUTH_TOKEN` (dezelfde code als eerder, uit `claude setup-token`).
3. Settings → Actions → General → *Workflow permissions*: **Read and write** én vink
   **Allow GitHub Actions to create and approve pull requests** aan.
4. Pas de twee regels bovenaan `CLAUDE.md` aan.

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
