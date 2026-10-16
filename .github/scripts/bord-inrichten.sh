#!/usr/bin/env bash
# Maakt het bord van dit project aan (naam = repo) met de kolommen ToDo, Review en Feedback, Realisatie, Uitlevering, Done,
# koppelt het aan de repo en maakt de labels aan. Mag vaker draaien. Vereist GH_TOKEN met scopes repo + project.
set -euo pipefail
REPO="${GITHUB_REPOSITORY:-$(gh repo view --json nameWithOwner --jq .nameWithOwner)}"
NAAM="${REPO#*/}"
USER_ID=$(gh api graphql -f query='query{viewer{id}}' --jq .data.viewer.id)
LOGIN=$(gh api graphql -f query='query{viewer{login}}' --jq .data.viewer.login)

PID=$(gh api graphql -f query='query{viewer{projectsV2(first:100){nodes{id title}}}}' \
  --jq ".data.viewer.projectsV2.nodes[] | select(.title==\"$NAAM\") | .id" | head -n1)
NIEUW=0
if [ -z "$PID" ]; then
  PID=$(gh api graphql -f query='mutation($o:ID!,$t:String!){createProjectV2(input:{ownerId:$o,title:$t}){projectV2{id}}}' \
    -f o="$USER_ID" -f t="$NAAM" --jq .data.createProjectV2.projectV2.id)
  NIEUW=1
  echo "Bord '$NAAM' aangemaakt"
fi

# Kolommen (Status-veld). Bestaande kolommen houden hun id, zodat kaartjes niet leeg raken.
VELD=$(gh api graphql -f query='query($p:ID!){node(id:$p){... on ProjectV2{field(name:"Status"){... on ProjectV2SingleSelectField{id options{id name}}}}}}' -f p="$PID")
FIELD_ID=$(echo "$VELD" | jq -r .data.node.field.id)
HUIDIG=$(echo "$VELD" | jq -r '[.data.node.field.options[].name] | join("|")')
if [ "$HUIDIG" != "ToDo|Review en Feedback|Realisatie|Uitlevering|Done" ]; then
  OPTIES=$(echo "$VELD" | jq --argjson gewenst '[{"name": "ToDo", "color": "GRAY", "description": "Nog te doen"}, {"name": "Review en Feedback", "color": "YELLOW", "description": "Jouw beurt: beoordelen of reageren"}, {"name": "Realisatie", "color": "BLUE", "description": "Agent of Claude Code is bezig"}, {"name": "Uitlevering", "color": "PURPLE", "description": "Testen en mergen"}, {"name": "Done", "color": "GREEN", "description": "Klaar"}]' '
    (.data.node.field.options) as $oud
    | {"todo":"ToDo","in progress":"Realisatie","done":"Done"} as $map
    | $gewenst | map(. as $g | ($oud | map(select(.name == $g.name or ($map[(.name|ascii_downcase)] // "") == $g.name)) | first) as $m
        | if $m then . + {id: $m.id} else . end)')
  jq -n --arg f "$FIELD_ID" --argjson o "$OPTIES" \
    '{query: "mutation($f:ID!,$o:[ProjectV2SingleSelectFieldOptionInput!]!){updateProjectV2Field(input:{fieldId:$f,singleSelectOptions:$o}){projectV2Field{... on ProjectV2SingleSelectField{id}}}}", variables: {f: $f, o: $o}}' \
    | gh api graphql --input - >/dev/null
  echo "Kolommen ingesteld"
fi

REPO_ID=$(gh api "repos/$REPO" --jq .node_id)
gh api graphql -f query='mutation($p:ID!,$r:ID!){linkProjectV2ToRepository(input:{projectId:$p,repositoryId:$r}){repository{id}}}' \
  -f p="$PID" -f r="$REPO_ID" >/dev/null 2>&1 || true

gh label create "agent: ontwerp" -R "$REPO" --color fbca04 --description "Agent maakt een kort plan ter beoordeling" --force
gh label create "agent: realiseren" -R "$REPO" --color 0e8a16 --description "Agent bouwt het ticket; testen en mergen automatisch" --force
gh label create "later" -R "$REPO" --color c5def5 --description "Vervolgpunt, later oppakken" --force
gh label delete "agent: prototype" -R "$REPO" --yes >/dev/null 2>&1 || true

if [ "$NIEUW" = 1 ]; then
  for n in $(gh issue list -R "$REPO" --state open --limit 200 --json number --jq '.[].number'); do
    BORD_TOKEN="${GH_TOKEN:-}" bash "$(dirname "$0")/status.sh" "$n" "ToDo" || true
  done
fi

NR=$(gh api graphql -f query='query($p:ID!){node(id:$p){... on ProjectV2{number}}}' -f p="$PID" --jq .data.node.number)
URL="https://github.com/users/$LOGIN/projects/$NR"
echo "Bord: $URL"
if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "## Bord klaar: [$NAAM]($URL)"
    echo "Eenmalig: open het bord, klik op de weergave (*View 1*) en kies **Layout: Board**. De kolommen volgen dan vanzelf het veld *Status*."
  } >> "$GITHUB_STEP_SUMMARY"
fi
