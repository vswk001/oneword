#!/usr/bin/env bash
set -euo pipefail

# OneWord uninstaller. Removes platform skills and the shared bundle (~/.oneword).
# Usage: bash uninstall.sh [--platform <claude-code|codex|cursor|opencode>]
#        Without --platform, removes OneWord from ALL detected platforms.

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

ONEWORD_HOME="${ONEWORD_HOME:-$HOME/.oneword}"

remove_skills() {
  local target="$1" pattern="$2" label="$3"
  if [ ! -d "$target" ]; then
    echo "  ${label}: nothing to remove (${target} not found)"
    return
  fi
  local found=0
  for entry in "$target"/$pattern; do
    [ -e "$entry" ] || continue
    rm -rf "$entry"
    found=1
  done
  if [ "$found" -eq 1 ]; then
    echo "  ${label}: removed skills from ${target}"
  else
    echo "  ${label}: nothing to remove in ${target}"
  fi
}

PLATFORM="${1:-}"
if [ "$PLATFORM" == "--platform" ] && [ -n "${2:-}" ]; then
  PLATFORM="$2"
fi

echo -e "${GREEN}Uninstalling OneWord...${NC}"

case "${PLATFORM:-all}" in
  claude-code)  remove_skills "$HOME/.claude/skills" "oneword-*" "Claude Code" ;;
  codex)        remove_skills "$HOME/.agents/skills" "oneword-*" "Codex CLI" ;;
  cursor)       remove_skills ".cursor/rules" "oneword-*.mdc" "Cursor" ;;
  opencode)     remove_skills "commands" "oneword-*.md" "OpenCode" ;;
  all)
    remove_skills "$HOME/.claude/skills" "oneword-*" "Claude Code"
    remove_skills "$HOME/.agents/skills" "oneword-*" "Codex CLI"
    remove_skills ".cursor/rules" "oneword-*.mdc" "Cursor"
    remove_skills "commands" "oneword-*.md" "OpenCode"
    ;;
  *)
    echo -e "${RED}Unknown platform: $PLATFORM${NC}"
    echo "Supported: claude-code, codex, cursor, opencode, or omit for all"
    exit 1
    ;;
esac

if [ -d "$ONEWORD_HOME" ]; then
  rm -rf "$ONEWORD_HOME"
  echo "  Removed shared bundle: ${ONEWORD_HOME}"
else
  echo "  Shared bundle: nothing to remove (${ONEWORD_HOME} not found)"
fi

# Remove generated-project artifacts in the current directory, if present.
if [ -d ".oneword" ]; then
  rm -rf ".oneword"
  echo "  Removed local .oneword/ artifacts in $(pwd)"
fi

echo -e "${GREEN}OneWord uninstalled.${NC}"
