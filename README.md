# 🛠️ Werkplaats

Eén bord in GitHub waarop al je ideeën en projecten staan. Jij zet een kaartje in een kolom; de agent van die
kolom doet zijn werk in de cloud (GitHub Actions) en zet het resultaat als reactie op het kaartje.
Er gebeurt niets zonder dat jij een kaartje verzet. Elk project krijgt automatisch een eigen privé-repo.

## Hoe het werkt

```
 💡 Ideeën ──► 🔎 Inventariseren ──► 📦 Naar project ──► 🧪 Prototype ──► 💬 Feedback
                 analist                maakt repo          prototyper       (jij / indiener)
                                       + verhuist kaartje
     ──► 📐 Ontwerp ──► 📋 Te doen ──► 🔨 Bouwen ──► 🧪 Testen ──► 👀 Review ──► ✅ Klaar
          ontwerper     (taakkaartjes)   bouwer        tester       reviewer      merge + sluiten
```

**Een kaartje verplaatsen = het label zetten.** Open het kaartje (op het bord of in de GitHub-app op je telefoon)
en kies bij *Labels* de nieuwe fase, bijvoorbeeld `fase:prototype`. Het kaartje schuift dan vanzelf naar die kolom
en de agent start. Slepen op het bord verplaatst alleen het kaartje en start géén agent
(GitHub geeft bij een gratis account geen seintje als je sleept).

Op elk kaartje zie je de status van de agent:
- `agent:bezig` – hij is ermee bezig (meestal 2–10 minuten)
- `agent:klaar` – klaar, lees de reactie; jij bent weer aan de beurt
- `agent:fout` – vastgelopen; de reactie bevat een link naar wat er misging. Zet het label opnieuw om het nog eens te proberen.

### Ideeën toevoegen
- Jij of iemand die je hebt uitgenodigd (Settings → Collaborators): **Issues → New issue → Idee of wens** in deze repo.
  Kan ook vanuit de GitHub-app op je telefoon, met screenshots erbij.
- Wens of bug voor een bestaand project: maak het issue direct in de repo van dat project.
- Nieuwe issues komen vanzelf in de kolom **Ideeën**.

### Chatten
Schrijf in een reactie op een kaartje `@claude ...`, bijvoorbeeld:
- `@claude maak de knoppen in het prototype groter en zet de lijst bovenaan`
- `@claude wat is het verschil tussen optie 1 en 2 uit de inventarisatie?`
- `@claude splits taak T3 op in twee kaartjes`

Antwoorden op vragen van de analist doe je gewoon in een reactie, daarna zet je het label opnieuw.
Alleen jouw reacties en labels starten iets; anderen kunnen meelezen en reageren.

### Een nieuw project
1. Idee in **Ideeën** → zet `fase:inventariseren`. De analist stelt vragen en sluit af met
   `Project: <naam>` en `Stack: web|python`. Andere naam? Zet die regels zelf in een reactie.
2. Zet `fase:naar-project`. Bestaat het project nog niet, dan wordt een **privé-repo** aangemaakt vanuit de template
   (met alle agents, workflows en secrets) en verhuist het kaartje erheen. Bestaat het al, dan verhuist het kaartje alleen.
3. Verder met `fase:prototype` of `fase:ontwerp`.

### Afronden
`fase:klaar` op een taakkaartje: de tests draaien, de PR wordt gemerged, de branch opgeruimd en het kaartje gesloten.
Falen de tests, dan wordt er niets gemerged en krijg je een melding.

---

## Eenmalig opzetten (±20 minuten, alles in de browser)

1. **Claude GitHub App** installeren: https://github.com/apps/claude → *Install* → kies **All repositories**
   (dan werkt hij ook in projecten die later worden aangemaakt).
2. **Twee tokens maken**
   - `PROJECT_TOKEN`: https://github.com/settings/tokens/new (*classic*), scopes **repo**, **workflow** en **project**.
   - `CLAUDE_CODE_OAUTH_TOKEN`: in een terminal met Claude Code: `claude setup-token` (gebruikt je Claude-abonnement).
3. **Secrets toevoegen** in deze repo: Settings → Secrets and variables → Actions → *New repository secret*:
   `PROJECT_TOKEN`, `CLAUDE_CODE_OAUTH_TOKEN` en optioneel `CLOUDFLARE_API_TOKEN` + `CLOUDFLARE_ACCOUNT_ID`.
   De projectstarter kopieert ze automatisch naar elk nieuw project.
4. **Actions-rechten**: Settings → Actions → General → *Workflow permissions*: **Read and write**.
5. **Labels en bord**: Actions → **Setup werkplaats** → *Run workflow*. Open daarna het bord (link in de samenvatting
   van de run) en zet de weergave op **Board** met **Column by: Fase**. Tip: toon ook de velden *Labels* en *Repository*.
6. **Proefrit**: Issues → New issue → *Idee of wens* → daarna label `fase:inventariseren` en kijk bij *Actions* mee.

### Prototypes online (optioneel, gratis)
Bij een privé-repo op GitHub Free kan GitHub Pages niet. Daarom kunnen projecten via **Cloudflare Pages** online
(gratis account op cloudflare.com → *API Tokens* → template "Edit Cloudflare Pages" + je Account ID).
Elk project komt dan op `https://<project>.pages.dev`, en elke PR krijgt een eigen proberen-link.
Let op: die adressen zijn te bezoeken voor wie de link heeft. Zonder Cloudflare download je het prototype en open je het lokaal.

### Kosten
- GitHub Free: 2.000 Actions-minuten per maand voor privé-repo's; een agent-run duurt meestal 2–10 minuten.
- Claude: via je abonnement (token uit `claude setup-token`); de runs tellen mee voor je gebruikslimiet.

---

## Onderhoud
- **Agents aanpassen**: bewerk `template/basis/.claude/agents/*.md` (en de kopie in `.claude/agents/`).
- **Bestaand project bijwerken** met de nieuwste agents en workflows: `bash scripts/bijwerken.sh <projectnaam>` (vereist `gh`).
- **Nieuwe stack**: maak een map in `template/` met minimaal `README.md` en `run-tests.sh`.
- De agents werken ook lokaal: open een project in Claude Code en zeg bijv. "gebruik de reviewer-agent".
