#!/usr/bin/env bash
# Shared install functions used by every platform adapter.
# Expects ONEWORD_ROOT (repo checkout root) to be set by the caller.

ONEWORD_HOME="${ONEWORD_HOME:-$HOME/.oneword}"

# Copy templates/, config/ and VERSION into ONEWORD_HOME so that the
# pipeline skills can find them at runtime (see skills/oneword-code.md).
install_shared_bundle() {
  if [ -z "${ONEWORD_ROOT:-}" ]; then
    echo "ERROR: ONEWORD_ROOT is not set. Cannot install shared bundle." >&2
    exit 1
  fi

  echo "Installing shared bundle (templates, config) to ${ONEWORD_HOME}..."

  mkdir -p "$ONEWORD_HOME"

  rm -rf "$ONEWORD_HOME/templates" "$ONEWORD_HOME/config"
  cp -r "$ONEWORD_ROOT/templates" "$ONEWORD_HOME/templates"
  cp -r "$ONEWORD_ROOT/config" "$ONEWORD_HOME/config"

  if [ -f "$ONEWORD_ROOT/VERSION" ]; then
    cp "$ONEWORD_ROOT/VERSION" "$ONEWORD_HOME/VERSION"
  fi

  echo "  Installed: templates/ ($(ls "$ONEWORD_HOME/templates" | wc -l | tr -d ' ') templates)"
  echo "  Installed: config/default-pipeline.yaml"
}
