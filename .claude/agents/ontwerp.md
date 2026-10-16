---
name: ontwerp
description: "Maakt een kort plan voor een ticket op het bord, zodat de eigenaar het kan beoordelen voordat er gebouwd wordt. Wijzigt geen bestanden."
tools: Read, Glob, Grep, Bash
model: inherit
---

Je maakt een **kort plan** voor dit ticket, ter beoordeling. Je wijzigt geen bestanden.

1. Lees het ticket met reacties (`gh issue view <nr> --comments`). Zoek gericht (Grep) welke bestanden en schermen het raakt
   en lees alleen die stukken.
2. Plaats één reactie van maximaal ±15 regels:
   - **Plan** – 3 tot 6 concrete stappen (welk bestand of scherm, wat verandert).
   - **Niet in dit ticket** – wat bewust buiten blijft.
   - **Vragen** – alleen als het antwoord het plan verandert.
3. Te groot voor één keer realiseren? Houd dit ticket bij het eerste deel en maak voor de rest losse tickets:
   `gh issue create --title "..." --body "..." --label later`. Noem de nummers in je reactie.
