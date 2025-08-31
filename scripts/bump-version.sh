#!/usr/bin/env bash
set -euo pipefail

# Bump app version across theme + plugin and commit in submodule + superproject.
#
# Usage:
#   scripts/bump-version.sh --type patch      # +0.0.1
#   scripts/bump-version.sh --type minor      # +0.1.0
#   scripts/bump-version.sh --to 1.2.3        # set explicit version
#   scripts/bump-version.sh --type patch --no-commit  # update files only
#
# Notes:
# - Reads current version from plugin define('WH_INVENTORY_VERSION','x.y.z').
# - Updates:
#   - app/public/wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php
#     * Header: "Version: x.y.z"
#     * Constant: WH_INVENTORY_VERSION
#   - app/public/wp-content/themes/warehouse-inventory/style.css (header Version: x.y.z)
# - Commits inside submodule (app/public) and then updates superproject pointer.

die() { echo "Error: $*" >&2; exit 1; }

TYPE=""
TARGET=""
COMMIT=1
while [[ $# -gt 0 ]]; do
  case "$1" in
    --type) TYPE=${2:-}; shift 2;;
    --to) TARGET=${2:-}; shift 2;;
    --no-commit) COMMIT=0; shift;;
    -h|--help) sed -n '1,40p' "$0"; exit 0;;
    *) die "Unknown arg: $1";;
  esac
done

SUB=app/public
# Absolute paths from superproject root (for editing)
PLUGIN="$SUB/wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php"
THEME_CSS="$SUB/wp-content/themes/warehouse-inventory/style.css"
# Relative paths inside submodule (for git add)
REL_PLUGIN="wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php"
REL_THEME_CSS="wp-content/themes/warehouse-inventory/style.css"

[[ -f "$PLUGIN" ]] || die "Plugin file not found: $PLUGIN"
[[ -f "$THEME_CSS" ]] || die "Theme style.css not found: $THEME_CSS"

# Extract current version from plugin constant
CUR=$(rg -No "define\('WH_INVENTORY_VERSION',[[:space:]]*'([0-9]+\.[0-9]+\.[0-9]+)'\)" "$PLUGIN" | sed -E "s/.*'([0-9]+\.[0-9]+\.[0-9]+)'.*/\1/" | head -n1)
[[ -n "$CUR" ]] || die "Could not determine current version"

inc_patch() { IFS=. read -r a b c <<< "$CUR"; c=$((c+1)); echo "$a.$b.$c"; }
inc_minor() { IFS=. read -r a b c <<< "$CUR"; b=$((b+1)); echo "$a.$b.0"; }

if [[ -n "$TARGET" ]]; then
  NEW="$TARGET"
elif [[ "$TYPE" == patch ]]; then
  NEW=$(inc_patch)
elif [[ "$TYPE" == minor ]]; then
  NEW=$(inc_minor)
else
  die "Specify --type patch|minor or --to X.Y.Z"
fi

echo "Bumping version: $CUR -> $NEW"

# Portable in-place sed helper (macOS/BSD vs GNU)
sed_inplace() {
  local expr=$1 file=$2
  if sed --version >/dev/null 2>&1; then
    sed -i -E "$expr" "$file"
  else
    sed -i '' -E "$expr" "$file"
  fi
}

# Update plugin header Version and constant
sed_inplace "s/^([[:space:]]*\*[[:space:]]*Version:[[:space:]]*)[0-9]+\.[0-9]+\.[0-9]+/\\1$NEW/" "$PLUGIN"
sed_inplace "s/(define\('WH_INVENTORY_VERSION',[[:space:]]*')([0-9]+\.[0-9]+\.[0-9]+)('\))/\\1$NEW\\3/" "$PLUGIN"

# Update theme style.css header
sed_inplace "s/^(Version:[[:space:]]*)[0-9]+\.[0-9]+\.[0-9]+/\\1$NEW/" "$THEME_CSS"

if [[ $COMMIT -eq 1 ]]; then
  (cd "$SUB" && git add "$REL_PLUGIN" "$REL_THEME_CSS" && git commit -m "Release: bump version to $NEW")
  git add "$SUB" && git commit -m "Release: update app/public to $NEW"
  echo "Committed version bump to $NEW."
else
  echo "Updated files only (no commit)."
fi

