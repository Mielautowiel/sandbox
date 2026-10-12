# __PROJECT__

Dit is een **projectrepo** van de werkplaats. Centrale repo (ideeën, gereedschap): __HUB__.

Stack: __STACK__
**Wat:** __TITEL__

## Werkwijze
Het werk wordt aangestuurd vanaf het bord "Werkplaats". De eigenaar zet een kaartje in een kolom (fase-label);
daarna doet de agent van die kolom zijn werk en zet een reactie op het kaartje. Agents gaan nooit zelf door naar een volgende fase.

| Kolom | Label | Wie |
|---|---|---|
| Ideeën | `fase:ideeen` | - |
| Inventariseren | `fase:inventariseren` | analist |
| Naar project | `fase:naar-project` | projectstarter (centrale repo) |
| Prototype | `fase:prototype` | prototyper |
| Feedback | `fase:feedback` | - |
| Ontwerp | `fase:ontwerp` | ontwerper |
| Te doen | `fase:te-doen` | - |
| Bouwen | `fase:bouwen` | bouwer |
| Testen | `fase:testen` | tester |
| Review | `fase:review` | reviewer |
| Klaar | `fase:klaar` | merge (automatisch, zonder AI) |
| Geparkeerd | `fase:geparkeerd` | - |

## Indeling
- `docs/idee.md` – inventarisatie · `docs/feedback.md` – prototypeversies en feedback · `docs/ontwerp.md` – ontwerp
- `prototype/` – wegwerp-prototype · `src/` + `tests/` – code · `run-tests.sh` – draait ALLE tests
- `CHANGELOG.md` – één regel per wijziging

## Kwaliteit
- Logica los van de UI; elke nieuwe functie minimaal één test; bestaande tests blijven groen.
- Geen secrets of persoonsgegevens in code; geen dependencies zonder reden. Klein houden: hobbywerk.
