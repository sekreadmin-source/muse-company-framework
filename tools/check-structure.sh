#!/usr/bin/env bash
# check-structure.sh — verify an installed Muse home has the framework's
# structural pieces in place. Reports MISSING lines; exits non-zero if any.
#
# Usage: tools/check-structure.sh [target_home]
set -uo pipefail

TARGET_HOME="${1:-$HOME}"
FAIL=0

need() {
  if [ -e "$TARGET_HOME/$1" ]; then
    echo "ok      $1"
  else
    echo "MISSING $1"
    FAIL=1
  fi
}

need "AGENTS.md"
need "SOUL.md"
need "IDENTITY.md"
need "USER.md"
need "MEMORY.md"
need "workspace/your_files"

if [ -d "$TARGET_HOME/workspace/divisi" ]; then
  for d in "$TARGET_HOME/workspace/divisi"/*/; do
    [ -d "$d" ] || continue
    for f in WORKFLOW.md WORKFLOW-AGENT.md TASKS.md; do
      need "workspace/divisi/$(basename "$d")/$f"
    done
  done
else
  echo "MISSING workspace/divisi (no divisions installed)"
  FAIL=1
fi

if [ "$FAIL" -eq 0 ]; then
  echo "Structure complete."
else
  echo "Structure incomplete — see MISSING lines above." >&2
fi
exit "$FAIL"
