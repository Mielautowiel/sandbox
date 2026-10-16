---
name: ticket
description: "Maak een los ticket op het bord voor iets wat later moet gebeuren (ook input voor Claude of Claude Code), zonder het nu te bouwen."
argument-hint: "<wat moet er later gebeuren>"
allowed-tools: Bash(gh issue create:*)
---

Maak een los ticket voor: $ARGUMENTS

1. Schrijf een korte titel en een body met:
   - **Wat en waarom** (1-3 zinnen)
   - **Waar** (bestanden of schermen, als je dat weet)
   - **Klaar als** (1-3 bullets)
2. `gh issue create --title "<titel>" --body "<body>" --label later`. Het ticket komt vanzelf in **ToDo** op het bord.
3. Noem het nummer en ga verder waar je was. Bouw het niet nu.
