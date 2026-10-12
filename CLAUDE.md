# Project

> Pas deze twee regels aan per project.
**Wat:** <één zin wat dit project doet>
**Stack:** web (HTML/CSS/JavaScript, geen build-stap) – tests met `node --test`

## Afspraken
- Klein houden: hobbyproject, kleinste bruikbare versie eerst.
- Logica in `src/`, los van de UI, zodat het testbaar is. Tests in `tests/`.
- `run-tests.sh` draait **alle** tests (exit-code ≠ 0 bij falen). Na elke wijziging moet die groen zijn.
- Geen secrets of persoonsgegevens in de code; geen dependencies zonder goede reden.
- Code en commits in het Engels; documentatie en reacties in het Nederlands.

## Agents
Op een ticket kies je een agent met een label; ze staan in `.claude/agents/`:
- `agent: prototype` – klikbaar wegwerp-prototype in `prototype/index.html`
- `agent: ontwerp` – plan en takenlijst in `docs/ontwerp.md`
- `agent: realiseren` – bouwt het echt, met tests
Testen en mergen gaan daarna automatisch. In VS Code roep je ze aan met bijv. `@agent-realiseren`.
