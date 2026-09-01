#!/usr/bin/env bash
set -euo pipefail

# OneWord installer.
#
# Works in two modes:
#   1. Run from a repo checkout:        bash install.sh [--platform <name>]
#   2. Piped from the network:          curl -fsSL <url> | bash
#      (The repo is cloned to a temp dir, installed from there, then cleaned up.)

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

REPO_URL="https://github.com/vswk001/oneword.git"

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

# Resolve the installer's own directory. When piped via `curl | bash`,
# BASH_SOURCE is absent — detect that and clone the repo first.
resolve_script_dir() {
  local script_path="${BASH_SOURCE[0]:-}"
  if [ -n "$script_path" ] && [ -f "$script_path" ]; then
    dirname "$script_path"
  else
    echo ""
  fi
}

SCRIPT_DIR="$(resolve_script_dir)"
ONEWORD_ROOT=""

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/skills" ]; then
  ONEWORD_ROOT="$(cd "$SCRIPT_DIR" && pwd)"
else
  # Piped mode (curl | bash): clone to a temp dir and re-exec from there.
  TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/oneword-install.XXXXXX")"
  cleanup() { rm -rf "$TEMP_DIR"; }
  trap cleanup EXIT

  echo "Downloading OneWord..."
  if ! command -v git &>/dev/null; then
    echo -e "${RED}git is required to install OneWord. Please install git first.${NC}" >&2
    exit 1
  fi
  git clone --depth 1 "$REPO_URL" "$TEMP_DIR/oneword"
  ONEWORD_ROOT="$TEMP_DIR/oneword"
fi

if [ -f "$ONEWORD_ROOT/VERSION" ]; then
  echo "OneWord version: $(cat "$ONEWORD_ROOT/VERSION")"
fi

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

echo ""
echo "To remove OneWord later, run: bash $ONEWORD_ROOT/uninstall.sh --platform $PLATFORM"
