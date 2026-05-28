#!/usr/bin/env bash
set -euo pipefail

ONEWORD_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

detect_platform() {
  if command -v claude &>/dev/null; then
    echo "claude-code"
  elif command -v codex &>/dev/null; then
    echo "codex"
  elif [ -d ".cursor" ]; then
    echo "cursor"
  elif command -v opencode &>/dev/null; then
    echo "opencode"
  else
    echo ""
  fi
}

PLATFORM="${1:-}"
if [ "$PLATFORM" == "--platform" ] && [ -n "${2:-}" ]; then
  PLATFORM="$2"
fi

if [ -z "$PLATFORM" ]; then
  PLATFORM=$(detect_platform)
fi

if [ -z "$PLATFORM" ]; then
  echo -e "${RED}Could not detect platform. Please specify:${NC}"
  echo "  bash install.sh --platform claude-code"
  echo "  bash install.sh --platform codex"
  echo "  bash install.sh --platform cursor"
  echo "  bash install.sh --platform opencode"
  exit 1
fi

echo -e "${GREEN}Installing OneWord for ${PLATFORM}...${NC}"

case "$PLATFORM" in
  claude-code)
    bash "$ONEWORD_ROOT/adapters/claude-code/install.sh"
    ;;
  codex)
    bash "$ONEWORD_ROOT/adapters/codex/install.sh"
    ;;
  cursor)
    bash "$ONEWORD_ROOT/adapters/cursor/install.sh"
    ;;
  opencode)
    bash "$ONEWORD_ROOT/adapters/opencode/install.sh"
    ;;
  *)
    echo -e "${RED}Unknown platform: $PLATFORM${NC}"
    echo "Supported: claude-code, codex, cursor, opencode"
    exit 1
    ;;
esac
