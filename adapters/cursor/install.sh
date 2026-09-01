#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONEWORD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET=".cursor/rules"

# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

echo "Installing OneWord skills for Cursor..."

install_shared_bundle
mkdir -p "$TARGET"

for skill in "$ONEWORD_ROOT"/skills/oneword-*.md; do
  name=$(basename "$skill" .md)
  content=$(cat "$skill")

  cat > "$TARGET/$name.mdc" << MDC_EOF
---
description: OneWord skill: $name
globs:
alwaysApply: false
---

$content
MDC_EOF

  echo "  Installed: $name.mdc"
done

echo ""
echo "OneWord installed for Cursor!"
echo "Usage: In Agent chat, reference @oneword-build <your requirement>"
