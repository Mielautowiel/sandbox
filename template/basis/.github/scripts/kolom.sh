#!/usr/bin/env bash
# Vertaalt een fase-label naar de kolomnaam op het bord.
case "$1" in
  fase:ideeen) echo "Ideeën" ;;
  fase:inventariseren) echo "Inventariseren" ;;
  fase:naar-project) echo "Naar project" ;;
  fase:prototype) echo "Prototype" ;;
  fase:feedback) echo "Feedback" ;;
  fase:ontwerp) echo "Ontwerp" ;;
  fase:te-doen) echo "Te doen" ;;
  fase:bouwen) echo "Bouwen" ;;
  fase:testen) echo "Testen" ;;
  fase:review) echo "Review" ;;
  fase:klaar) echo "Klaar" ;;
  fase:geparkeerd) echo "Geparkeerd" ;;
  *) echo "" ;;
esac
