---
name: uitleveren
description: "Lever het lokale werk uit: tests, pull request, mergen naar main en het ticket naar Done. Alleen als de eigenaar zegt dat het klaar is."
disable-model-invocation: true
allowed-tools: Bash(bash run-tests.sh:*) Bash(git status:*) Bash(git log:*) Bash(git push:*) Bash(git switch:*) Bash(git pull:*) Bash(git branch:*) Bash(gh pr create:*) Bash(gh pr merge:*) Bash(gh pr view:*) Bash(bash .github/scripts/status.sh:*)
---

Lever het huidige werk uit.

1. Controleer dat je op een `lokaal/...`-branch zit en dat alles gecommit is. Staat er nog iets open, vraag of het mee moet
   (dan als eigen kleine commit).
2. Draai `bash run-tests.sh` (als die bestaat). Rood? Stop, laat zien wat faalt en lever niet uit.
3. Ticketnummer: uit de branchnaam (`lokaal/<nr>-...`) plus eventuele tickets die de eigenaar noemt.
   Zet ze op Uitlevering: `bash .github/scripts/status.sh <nr> "Uitlevering"`.
4. `git push -u origin HEAD`, dan
   `gh pr create --base main --title "<korte samenvatting>" --body "<één bullet per commit>\n\nCloses #<nr>"`
   (geen ticket? laat `Closes` weg).
5. `gh pr merge --merge --delete-branch` (gewone merge, zodat de kleine commits los zichtbaar blijven), dan `git switch main && git pull`.
6. Meld in 2-3 regels wat er uitgeleverd is en de PR-link. Gesloten tickets gaan vanzelf naar **Done**.
