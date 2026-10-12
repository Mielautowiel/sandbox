#!/usr/bin/env bash
# Draait alle tests. Exit-code != 0 als iets faalt.
set -euo pipefail
cd "$(dirname "$0")"
PY=$(command -v python3 || command -v python)
$PY -m pytest -q tests/
