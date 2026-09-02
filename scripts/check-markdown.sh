#!/usr/bin/env bash
# Checks every markdown file in the repo for balanced code fences.
# A skill file with an unbalanced fence renders wrongly and confuses the
# agent executing it (this exact bug shipped once — see git history).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0

while IFS= read -r file; do
  # Count fence lines: lines that start a fenced block (``` optionally followed by a language)
  fences=$(grep -cE '^[[:space:]]*```' "$file" || true)
  if [ $((fences % 2)) -ne 0 ]; then
    echo "FAIL: unbalanced code fences ($fences fence lines) in $file"
    fail=1
  fi
done < <(find "$REPO_ROOT" -name "*.md" -not -path "*/node_modules/*")

# Template manifests: every template dir must declare itself
for dir in "$REPO_ROOT"/templates/*/; do
  if [ ! -f "$dir/template.yaml" ]; then
    echo "FAIL: missing template.yaml in $dir"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "Markdown/template checks FAILED."
  exit 1
fi

echo "Markdown fence check: OK ($(find "$REPO_ROOT" -name '*.md' -not -path '*/node_modules/*' | wc -l | tr -d ' ') files)"
template_count=$(find "$REPO_ROOT/templates" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
echo "Template manifest check: OK (${template_count} templates)"
