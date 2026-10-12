# Werkplaats – centrale repo

Dit is de **centrale repo** van de werkplaats: hier komen ideeën binnen (issues) en hier staat het gereedschap
(agents, workflows en templates). Elk project heeft een eigen privé-repo onder dezelfde eigenaar.

## Werkwijze
Alles loopt via het bord "Werkplaats" (GitHub Projects). De eigenaar zet een kaartje in een kolom door het
fase-label te zetten; de agent van die kolom doet dan zijn werk en reageert op het kaartje. Agents gaan nooit
zelf door naar een volgende fase.

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

In deze repo is vooral **Inventariseren** (analist) en **Naar project** (maakt de projectrepo en verhuist het kaartje) van belang.

## Indeling
- `.claude/agents/` – de agents (identiek aan die in elk project)
- `.github/workflows/` – agent, bord, chat, klaar, naar-project
- `template/basis/` – wat elk nieuw project krijgt; `template/web`, `template/python` – stack-specifiek
- `scripts/` – eenmalige setup en bijwerken van bestaande projecten
