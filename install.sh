#!/usr/bin/env bash
# install.sh — install the Muse Company Framework skeletons into a Muse home.
#
# Usage:
#   ./install.sh [target_home] [division_slug ...]
#
# With no division arguments, the divisions from the framework's example
# configuration (services, research) are scaffolded as a starting point.
# Existing files are NEVER overwritten; conflicting paths are reported and
# skipped so a live deployment cannot be clobbered by an install.
set -euo pipefail

TARGET_HOME="${1:-$HOME}"
shift || true

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_new() {
  # copy_new <source> <dest>
  if [ -e "$2" ]; then
    echo "skip (exists): $2"
  else
    mkdir -p "$(dirname "$2")"
    cp "$1" "$2"
    echo "installed:     $2"
  fi
}

echo "Installing framework skeletons into: $TARGET_HOME"

# Home identity/context skeletons
for f in AGENTS.md SOUL.md IDENTITY.md USER.md MEMORY.md; do
  copy_new "$SCRIPT_DIR/templates/$f" "$TARGET_HOME/$f"
done

# Governance skeletons + registers
mkdir -p "$TARGET_HOME/workspace/your_files"
for f in "$SCRIPT_DIR"/templates/governance/*.md; do
  copy_new "$f" "$TARGET_HOME/workspace/your_files/$(basename "$f")"
done
copy_new "$SCRIPT_DIR/templates/queue/worker-queue.md" \
         "$TARGET_HOME/workspace/worker-queue.md"

# Structural skills
mkdir -p "$TARGET_HOME/workspace/custom-skills"
for d in "$SCRIPT_DIR"/skills/*/; do
  name="$(basename "$d")"
  copy_new "$d/SKILL.md" "$TARGET_HOME/workspace/custom-skills/$name/SKILL.md"
done

# Built-in worker integration (Hermes) skeletons
if [ -d "$SCRIPT_DIR/workers/hermes" ]; then
  mkdir -p "$TARGET_HOME/workspace/workers/hermes"
  find "$SCRIPT_DIR/workers/hermes" -type f | while read -r f; do
    rel="${f#"$SCRIPT_DIR/workers/hermes/"}"
    copy_new "$f" "$TARGET_HOME/workspace/workers/hermes/$rel"
  done
fi

# 3D office visualization
if [ -d "$SCRIPT_DIR/visualization" ]; then
  mkdir -p "$TARGET_HOME/workspace/visualization"
  find "$SCRIPT_DIR/visualization" -type f | while read -r f; do
    rel="${f#"$SCRIPT_DIR/visualization/"}"
    copy_new "$f" "$TARGET_HOME/workspace/visualization/$rel"
  done
  # The viewer reads office.json next to index.html; seed it from the example.
  copy_new "$SCRIPT_DIR/visualization/office.json.example" \
           "$TARGET_HOME/workspace/visualization/viewer/office.json"
fi

# Starter divisions
if [ "$#" -gt 0 ]; then
  SLUGS=("$@")
else
  SLUGS=(services research)
fi
for slug in "${SLUGS[@]}"; do
  dest="$TARGET_HOME/workspace/divisi/$slug"
  if [ -e "$dest" ]; then
    echo "skip (exists): $dest"
    continue
  fi
  mkdir -p "$dest"
  for f in WORKFLOW.md WORKFLOW-AGENT.md TASKS.md; do
    cp "$SCRIPT_DIR/templates/division/$f" "$dest/$f"
  done
  echo "installed:     $dest"
done

echo
echo "Done. Next steps:"
echo "  1. Fill in USER.md, IDENTITY.md and your company configuration."
echo "  2. Replace the {{PLACEHOLDERS}} in each division's documents."
echo "  3. Run tools/check-structure.sh \"$TARGET_HOME\" to verify the layout."
echo "  4. Open Muse and introduce your COO to its company."
