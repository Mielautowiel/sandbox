#!/usr/bin/env bash
# Zet de nieuwste agents, workflows en scripts uit template/basis in een bestaande projectrepo.
# Gebruik: bash scripts/bijwerken.sh <projectnaam>
set -euo pipefail
NAAM="$1"
OWNER=$(gh api user --jq .login)
TMP=$(mktemp -d)
gh repo clone "$OWNER/$NAAM" "$TMP" -- -q
cp -r template/basis/.claude template/basis/.github "$TMP/"
cd "$TMP"
if git diff --quiet && [ -z "$(git status --porcelain)" ]; then echo "Al up-to-date."; exit 0; fi
git add .claude .github
git commit -qm "Update werkplaats agents and workflows"
git push -q
echo "Bijgewerkt: $OWNER/$NAAM"
