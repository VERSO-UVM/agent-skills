#!/usr/bin/env bash
# Validate skills and flag harness-specific wording.
# Usage: scripts/check.sh   (exit 1 on frontmatter errors; wording hits are warnings)
set -uo pipefail
cd "$(dirname "$0")/.."

errors=0
while IFS= read -r f; do
  dir=$(basename "$(dirname "$f")")
  head -1 "$f" | grep -q '^---$' || { echo "ERROR $f: missing frontmatter"; errors=$((errors+1)); continue; }
  fm=$(awk 'NR==1{next} /^---$/{exit} {print}' "$f")
  name=$(sed -n 's/^name: *//p' <<<"$fm")
  [ "$name" = "$dir" ] || { echo "ERROR $f: name '$name' must match folder '$dir' (lowercase, hyphens)"; errors=$((errors+1)); }
  grep -q '^description:' <<<"$fm" || { echo "ERROR $f: no description"; errors=$((errors+1)); }
done < <(find plugins -path '*/node_modules' -prune -o -name SKILL.md -print)

for m in .claude-plugin/marketplace.json .cursor-plugin/marketplace.json plugins/*/plugin.json plugins/*/.claude-plugin/plugin.json plugins/*/.cursor-plugin/plugin.json; do
  python3 -m json.tool "$m" >/dev/null 2>&1 || { echo "ERROR $m: invalid JSON"; errors=$((errors+1)); }
done

echo "--- harness-specific wording (review each; attribution is fine) ---"
grep -rnE 'AskQuestion|generalPurpose|\.mdc\b|~/\.cursor/rules|setup-pstack|is_background' plugins --include='*.md' || echo "none"

echo "--- $(find plugins -name SKILL.md | wc -l | tr -d ' ') skills, $errors errors"
[ "$errors" -eq 0 ]
