#!/usr/bin/env bash
# Maakt alle werkplaats-labels aan in repo <owner/repo> (of de huidige repo).
set -euo pipefail
R="${1:-}"
lbl() { gh label create "$1" --color "$2" --description "$3" --force ${R:+-R "$R"} >/dev/null; }
lbl "fase:ideeen" "0e8a16" "Kolom: Ideeën"
lbl "fase:inventariseren" "0e8a16" "Kolom: Inventariseren"
lbl "fase:naar-project" "0e8a16" "Kolom: Naar project"
lbl "fase:prototype" "0e8a16" "Kolom: Prototype"
lbl "fase:feedback" "0e8a16" "Kolom: Feedback"
lbl "fase:ontwerp" "0e8a16" "Kolom: Ontwerp"
lbl "fase:te-doen" "0e8a16" "Kolom: Te doen"
lbl "fase:bouwen" "0e8a16" "Kolom: Bouwen"
lbl "fase:testen" "0e8a16" "Kolom: Testen"
lbl "fase:review" "0e8a16" "Kolom: Review"
lbl "fase:klaar" "0e8a16" "Kolom: Klaar"
lbl "fase:geparkeerd" "0e8a16" "Kolom: Geparkeerd"
lbl "agent:bezig" "fbca04" "Een agent is hiermee bezig"
lbl "agent:klaar" "0e8a16" "Agent klaar, jouw beurt"
lbl "agent:fout" "d73a4a" "Agent liep vast, zie reactie"
lbl "taak" "0052cc" "Taak uit een ontwerp"
lbl "bug" "d73a4a" "Iets werkt niet"
lbl "idee" "1d76db" "Idee of wens"
echo "Labels klaar${R:+ in $R}"
