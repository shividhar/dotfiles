#!/usr/bin/env bash
set -euo pipefail

title="Claude Code"
msg="$1"

# Prefer CLAUDE_PROJECT_DIR if available; fall back to current dir
proj="${CLAUDE_PROJECT_DIR:-$PWD}"
dir="$(basename "$proj")"

terminal-notifier -title "${title}" -subtitle "${dir}" -message "${msg}" -sound default
