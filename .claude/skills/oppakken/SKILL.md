---
name: oppakken
description: "Pak een ticket van het bord lokaal op: status Realisatie, eigen branch, daarna in kleine stappen bouwen en laten zien."
argument-hint: "<ticketnummer>"
disable-model-invocation: true
allowed-tools: Bash(gh issue view:*) Bash(bash .github/scripts/status.sh:*) Bash(git switch:*) Bash(git pull:*) Bash(git status:*) Bash(git branch:*)
---

Pak ticket #$ARGUMENTS lokaal op.

1. `gh issue view $ARGUMENTS --comments` en vat in maximaal 5 regels samen wat er moet gebeuren. Onduidelijk? Stel de vraag.
2. Zijn er niet-gecommitte wijzigingen (`git status`), vraag dan eerst wat ermee moet.
   Anders: `git switch main && git pull`, dan `git switch -c lokaal/$ARGUMENTS-<korte-naam>`
   (bestaat die branch al, ga er dan op verder).
3. `bash .github/scripts/status.sh $ARGUMENTS "Realisatie"`
4. Noem de eerste kleine stap en begin. Werk verder volgens "Lokaal werken" in CLAUDE.md.
