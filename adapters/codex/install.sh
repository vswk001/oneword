#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONEWORD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET="$HOME/.agents/skills"

echo "Installing OneWord skills for OpenAI Codex..."

mkdir -p "$TARGET"

for skill in "$ONEWORD_ROOT"/skills/oneword-*.md; do
  name=$(basename "$skill" .md)
  skill_dir="$TARGET/$name"
  mkdir -p "$skill_dir"
  cp "$skill" "$skill_dir/skill.md"
  echo "  Installed: $name"
done

echo ""
echo "OneWord installed for Codex!"
echo "Usage: oneword-build <your requirement>"
