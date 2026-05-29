#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONEWORD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET="$HOME/.claude/skills"

echo "Installing OneWord skills for Claude Code..."

mkdir -p "$TARGET"

for skill in "$ONEWORD_ROOT"/skills/oneword-*.md; do
  name=$(basename "$skill" .md)
  skill_dir="$TARGET/$name"
  mkdir -p "$skill_dir"
  cp "$skill" "$skill_dir/SKILL.md"
  echo "  Installed: $name"
done

echo ""
echo "OneWord installed for Claude Code!"
echo "Usage: /oneword-build <your requirement>"
echo "Example: /oneword-build I want a bookkeeping app"
