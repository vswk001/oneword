#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONEWORD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET="commands"

# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

echo "Installing OneWord skills for OpenCode..."

install_shared_bundle
mkdir -p "$TARGET"

for skill in "$ONEWORD_ROOT"/skills/oneword-*.md; do
  name=$(basename "$skill" .md)
  cp "$skill" "$TARGET/$name.md"
  echo "  Installed: $name.md"
done

echo ""
echo "OneWord installed for OpenCode!"
echo "Usage: /oneword-build <your requirement>"
