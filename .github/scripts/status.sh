#!/usr/bin/env bash
# Zet ticket <nr> in kolom <status> op het bord van dit project (bord heet zoals de repo).
# Gebruik: bash .github/scripts/status.sh 12 "Realisatie"
# Faalt nooit hard: zonder bord of rechten geeft het alleen een melding.
set -uo pipefail
NR="${1:?ticketnummer}"; STATUS="${2:?status}"
melding() { echo "Bord niet bijgewerkt: $1" >&2; exit 0; }

if [ -n "${GITHUB_ACTIONS:-}" ]; then
  [ -n "${BORD_TOKEN:-}" ] || melding "secret PROJECT_TOKEN ontbreekt"
  export GH_TOKEN="$BORD_TOKEN"
fi
REPO="${GITHUB_REPOSITORY:-$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null)}"
[ -n "$REPO" ] || melding "repo onbekend"
OWNER="${REPO%%/*}"; TITEL="${BORD_TITEL:-${REPO#*/}}"

PROJECT_ID=$(gh api graphql -f query='query($o:String!){user(login:$o){projectsV2(first:100){nodes{id title}}}}' -f o="$OWNER" \
  --jq ".data.user.projectsV2.nodes[] | select(.title==\"$TITEL\") | .id" 2>/dev/null | head -n1)
[ -n "$PROJECT_ID" ] || melding "geen bord met de naam '$TITEL' (draai Actions -> Bord -> Run workflow)"

FIELD_ID=$(gh api graphql -f query='query($p:ID!){node(id:$p){... on ProjectV2{field(name:"Status"){... on ProjectV2SingleSelectField{id}}}}}' \
  -f p="$PROJECT_ID" --jq '.data.node.field.id' 2>/dev/null)
OPTION_ID=$(gh api graphql -f query='query($p:ID!){node(id:$p){... on ProjectV2{field(name:"Status"){... on ProjectV2SingleSelectField{options{id name}}}}}}' \
  -f p="$PROJECT_ID" --jq ".data.node.field.options[] | select(.name==\"$STATUS\") | .id" 2>/dev/null)
[ -n "$OPTION_ID" ] || melding "kolom '$STATUS' bestaat niet op het bord"

ISSUE_ID=$(gh api "repos/$REPO/issues/$NR" --jq .node_id 2>/dev/null)
[ -n "$ISSUE_ID" ] || melding "ticket #$NR niet gevonden"
ITEM_ID=$(gh api graphql -f query='mutation($p:ID!,$c:ID!){addProjectV2ItemById(input:{projectId:$p,contentId:$c}){item{id}}}' \
  -f p="$PROJECT_ID" -f c="$ISSUE_ID" --jq .data.addProjectV2ItemById.item.id 2>/dev/null)
[ -n "$ITEM_ID" ] || melding "ticket #$NR kon niet op het bord"
gh api graphql -f query='mutation($p:ID!,$i:ID!,$f:ID!,$o:String!){updateProjectV2ItemFieldValue(input:{projectId:$p,itemId:$i,fieldId:$f,value:{singleSelectOptionId:$o}}){projectV2Item{id}}}' \
  -f p="$PROJECT_ID" -f i="$ITEM_ID" -f f="$FIELD_ID" -f o="$OPTION_ID" >/dev/null 2>&1 || melding "status zetten mislukt"
echo "#$NR -> $STATUS"
