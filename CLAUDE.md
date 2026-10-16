# Project

> Pas deze regels aan per project.
**Wat:** <één zin wat dit project doet>
**Stack:** web (HTML/CSS/JavaScript, geen build-stap) – tests met `node --test`
**Preview:** https://<branch>-<projectnaam>.emiel86.workers.dev  (pas aan na het koppelen aan Cloudflare)

## Afspraken
- Klein houden: hobbyproject, kleinste bruikbare versie eerst.
- Logica in `src/`, los van de UI, zodat het testbaar is. Tests in `tests/`.
- `run-tests.sh` draait **alle** tests (exit-code ≠ 0 bij falen). Na elke wijziging moet die groen zijn.
- Geen secrets of persoonsgegevens in de code; geen dependencies zonder goede reden.
- Code en commits in het Engels; documentatie en reacties in het Nederlands.

## Zuinig met tokens
- Zoek eerst met Grep en lees dan alleen het stuk dat nodig is (Read met offset/limit). Lees geen grote bestanden helemaal.
- Pas grote bestanden aan met `Edit` op het stuk, niet het hele bestand opnieuw schrijven.

## Werkwijze
Twee paden; uitleg voor mensen staat in `docs/werkwijze.md`.

**Lokaal werken (deze laptop – grotere of iteratieve aanpassingen)**
- Werk op een branch `lokaal/...` (via `/oppakken <nr>` of zelf aangemaakt), nooit direct op main.
- Kleine stappen: één duidelijke wijziging per keer, elk een eigen commit met een korte Engelse message. Geen ongevraagde extra's.
- Na elke stap: `bash run-tests.sh` (als die er is) en zorg dat de preview draait: `node serve.js` op de achtergrond
  (eerst checken met `curl -s -o /dev/null -w "%{http_code}" http://localhost:8000`; alleen starten als hij niet draait).
  Meld dan in max 4 regels: wat er veranderd is, waar je het ziet (http://localhost:8000 + scherm/klik) en of er iets te kiezen is.
  **Stop daarna en wacht op feedback.**
- Werk je in een cloudsessie (eigenaar zit op zijn mobiel, localhost is voor hem niet te zien): push na elke stap de branch
  (`git push -u origin HEAD`) en meld de preview-link uit **Preview:** bovenaan in plaats van localhost.
  `<branch>` = branchnaam in kleine letters, `/` en andere tekens worden `-` (bijv. `lokaal/12-kalender` → `lokaal-12-kalender`).
  Houd branchnamen kort. Cloudflare bouwt de preview in ±1 minuut.
- Feedback verwerk je als een nieuwe kleine commit (geen amend of rebase), zodat elke aanpassing los te bekijken blijft.
- Iets voor later, buiten deze stap, of input voor Claude/Claude Code die later moet gebeuren? Maak een los ticket met
  `/ticket ...` (komt in ToDo op het bord) en bouw het niet nu.
- Uitleveren alleen als de eigenaar zegt dat het klaar is: `/uitleveren`.

**Bord (GitHub – kleine losse tickets)**
- Kolommen: ToDo · Review en Feedback · Realisatie · Uitlevering · Done.
- Label `agent: realiseren`: bouwt het ticket; testen en mergen gaan automatisch.
- Label `agent: ontwerp`: alleen als het eerst beoordeeld moet worden; geeft een kort plan als reactie.
