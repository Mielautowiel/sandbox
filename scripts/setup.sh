#!/usr/bin/env bash
# Eenmalig: labels in de centrale repo + het bord "Werkplaats" met veld "Fase".
# Draai vanuit de map van de centrale repo, na: gh auth login  en  gh auth refresh -s project
set -euo pipefail
OWNER=$(gh api user --jq .login)
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)

bash .github/scripts/labels.sh "$REPO"

NR=$(gh project list --owner "$OWNER" --format json --jq '.projects[] | select(.title=="Werkplaats") | .number' | head -1)
if [ -z "$NR" ]; then
  NR=$(gh project create --owner "$OWNER" --title "Werkplaats" --format json --jq .number)
  gh project field-create "$NR" --owner "$OWNER" --name "Fase" --data-type SINGLE_SELECT \
    --single-select-options "Ideeën,Inventariseren,Naar project,Prototype,Feedback,Ontwerp,Te doen,Bouwen,Testen,Review,Klaar,Geparkeerd"
  echo "Bord aangemaakt: nummer $NR"
else
  echo "Bord bestaat al: nummer $NR"
fi
gh project link "$NR" --owner "$OWNER" --repo "$REPO" || true

cat <<EOF

Bijna klaar. Nog 1 handeling in de browser:
  https://github.com/users/$OWNER/projects/$NR
  -> klik op de weergave (View 1) -> Layout: Board -> "Column by": Fase
  Tip: zet ook de velden Labels en Repository aan, dan zie je agent:bezig/klaar en het project op elk kaartje.
EOF
