# Werkwijze

Er zijn twee manieren om iets te laten bouwen. Elk project heeft een eigen bord in GitHub (Projects, met dezelfde naam als
de repo) met vijf kolommen:

| Kolom | Betekenis |
|---|---|
| **ToDo** | Nog te doen. Nieuwe tickets en vervolgpunten komen hier vanzelf. |
| **Review en Feedback** | Jouw beurt: een plan beoordelen, een vraag beantwoorden of kijken waarom tests faalden. |
| **Realisatie** | Er wordt aan gewerkt: door een agent in GitHub of door Claude Code op je laptop. |
| **Uitlevering** | Testen en mergen naar main. |
| **Done** | Klaar. |

De kaartjes verschuiven automatisch; je hoeft zelf niet te slepen.

## 1. Lokaal op je laptop (grotere of iteratieve aanpassingen)
Open het project in VS Code en start Claude.

- `/oppakken 12` – pakt ticket 12 op: branch `lokaal/12-...`, kaartje naar **Realisatie**.
  Zonder ticket mag ook: zeg gewoon wat je wilt.
- Claude werkt in **kleine stappen**: één wijziging, één commit, tests, en de preview draait
  (`node serve.js` → http://localhost:8000). Daarna stopt Claude en vertelt wat je waar kunt bekijken.
- Geef feedback ("knop groter", "andere tekst"); elke aanpassing wordt weer een eigen kleine commit.
- `/ticket <omschrijving>` – iets voor later? Het wordt een los ticket in **ToDo**, zonder het nu te bouwen.
- `/uitleveren` – als jij zegt dat het klaar is: tests, pull request, merge naar main, kaartje naar **Done**.

## 2. Via het bord (kleine losse tickets)
1. Maak een ticket (**Issues → New issue → Ticket**). Het komt in **ToDo**.
2. Zet een label:
   - `agent: realiseren` – de agent bouwt het (**Realisatie**), test en merget (**Uitlevering**) → **Done**.
     Falen de tests, dan wordt er niets gemerged en gaat het kaartje naar **Review en Feedback**.
   - `agent: ontwerp` – alleen als je eerst wilt beoordelen: de agent zet een kort plan als reactie
     (**Review en Feedback**). Reageer, en zet daarna `agent: realiseren`.
3. Ziet een agent iets wat buiten het ticket valt, dan maakt hij een **los ticket** (label `later`) in **ToDo**.

Alleen jij (eigenaar van de repo) kunt een agent starten.

## 3. Op je mobiel
- **Klein ticket:** GitHub-app → ticket maken → label `agent: realiseren` (of eerst `agent: ontwerp`).
- **Iteratief:** Claude-app → sessie met deze repo. Claude werkt in dezelfde kleine stappen, pusht elke stap
  en stuurt een **preview-link** (bijv. `https://lokaal-12-kalender.<project>.pages.dev`) die je op je telefoon opent.
  Klaar? Typ `/uitleveren`.

## Eenmalig per project
In PowerShell, in je map `projectstarter`:
```
powershell -ExecutionPolicy Bypass -File .\nieuw-project.ps1 <repo-naam> -Bestaand
```
Dit zet de tokens, de Actions-rechten en maakt het bord met de kolommen en labels aan.
Open daarna het bord en kies één keer **Layout: Board** bij de weergave.

**Preview-links (Cloudflare Pages, gratis):** Cloudflare-dashboard → **Workers & Pages → Create → Pages →
Connect to Git** → kies de repo → build command leeg, output directory leeg → **Save and Deploy**.
Elke branch krijgt dan automatisch een eigen link. Zet het adres (bijv. `mijnproject.pages.dev`) bij **Preview:** bovenin `CLAUDE.md`.
