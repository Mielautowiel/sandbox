#!/usr/bin/env bash
# Draait ALLE tests. Exit-code != 0 als iets faalt.
set -euo pipefail
cd "$(dirname "$0")"
node --test tests/*.test.js
