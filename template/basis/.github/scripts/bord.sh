#!/usr/bin/env bash
# Zet issue <owner/repo> <nr> in kolom <kolom> van het bord "Werkplaats" (veld "Fase").
# Vereist GH_TOKEN met scopes repo + project.
set -euo pipefail
REPO="$1"; NR="$2"; KOLOM="$3"
OWNER="${REPO%%/*}"
TITEL="${PROJECT_TITEL:-Werkplaats}"
[ -n "$KOLOM" ] || { echo "Geen kolom, niets te doen"; exit 0; }

ISSUE_ID=$(gh api "repos/$REPO/issues/$NR" --jq .node_id)
PROJECT_ID=$(gh api graphql -f query='query($o:String!){user(login:$o){projectsV2(first:50){nodes{id title}}}}' -f o="$OWNER" \
  | jq -r --arg t "$TITEL" '.data.user.projectsV2.nodes[] | select(.title==$t) | .id' | head -1)
[ -n "$PROJECT_ID" ] || { echo "Bord '$TITEL' niet gevonden"; exit 0; }

VELD=$(gh api graphql -f query='query($p:ID!){node(id:$p){... on ProjectV2{fields(first:50){nodes{... on ProjectV2SingleSelectField{id name options{id name}}}}}}}' -f p="$PROJECT_ID" \
  | jq '[.data.node.fields.nodes[] | select(.name=="Fase")][0]')
[ "$VELD" != "null" ] || { echo "Veld Fase niet gevonden op het bord"; exit 0; }
FIELD_ID=$(echo "$VELD" | jq -r '.id')
OPTION_ID=$(echo "$VELD" | jq -r --arg k "$KOLOM" '.options[] | select(.name==$k) | .id')
[ -n "$OPTION_ID" ] || { echo "Kolom '$KOLOM' bestaat niet in veld Fase"; exit 0; }

ITEM_ID=$(gh api graphql -f query='mutation($p:ID!,$c:ID!){addProjectV2ItemById(input:{projectId:$p,contentId:$c}){item{id}}}' \
  -f p="$PROJECT_ID" -f c="$ISSUE_ID" --jq .data.addProjectV2ItemById.item.id)
gh api graphql -f query='mutation($p:ID!,$i:ID!,$f:ID!,$o:String!){updateProjectV2ItemFieldValue(input:{projectId:$p,itemId:$i,fieldId:$f,value:{singleSelectOptionId:$o}}){projectV2Item{id}}}' \
  -f p="$PROJECT_ID" -f i="$ITEM_ID" -f f="$FIELD_ID" -f o="$OPTION_ID" >/dev/null
echo "$REPO#$NR -> $KOLOM"
