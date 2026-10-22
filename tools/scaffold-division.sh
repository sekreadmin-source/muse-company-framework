#!/usr/bin/env bash
# scaffold-division.sh — create a division folder from the framework templates.
#
# Usage:
#   tools/scaffold-division.sh <slug> "<Division Name>" <TASK_PREFIX> [target_home]
#
# Example:
#   tools/scaffold-division.sh services "Services Division" SVC ~/muse-home
#
# Creates <target_home>/workspace/divisi/<slug>/ with WORKFLOW.md,
# WORKFLOW-AGENT.md and TASKS.md, placeholders substituted.
set -euo pipefail

SLUG="${1:?usage: scaffold-division.sh <slug> \"<Name>\" <PREFIX> [target_home]}"
NAME="${2:?missing division name}"
PREFIX="${3:?missing task-id prefix}"
TARGET_HOME="${4:-$HOME}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
DEST="$TARGET_HOME/workspace/divisi/$SLUG"

if [ -e "$DEST" ]; then
  echo "Refusing to overwrite existing division folder: $DEST" >&2
  exit 1
fi

mkdir -p "$DEST"
for f in WORKFLOW.md WORKFLOW-AGENT.md TASKS.md; do
  sed -e "s/{{DIVISION_NAME}}/$NAME/g" \
      -e "s/{{PREFIX}}/$PREFIX/g" \
      "$REPO_DIR/templates/division/$f" > "$DEST/$f"
done

echo "Division scaffolded: $DEST"
echo "Next: register the division in config/company.yaml and the agent registry,"
echo "create its chat, and write its first board items."
