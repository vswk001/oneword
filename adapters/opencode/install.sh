#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONEWORD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET="commands"

echo "Installing OneWord skills for OpenCode..."

mkdir -p "$TARGET"

for skill in "$ONEWORD_ROOT"/skills/oneword-*.md; do
  name=$(basename "$skill" .md)
  cp "$skill" "$TARGET/$name.md"
  echo "  Installed: $name.md"
done

echo ""
echo "OneWord installed for OpenCode!"
echo "Usage: /oneword-build <your requirement>"
