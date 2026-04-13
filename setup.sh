#!/usr/bin/env bash
#
# MFL Workspace Setup
# Clones all workspace repos the user has access to.
# Repos without access are skipped silently with an info message.
#
set -euo pipefail

WORKSPACE_DIR="$(cd "$(dirname "$0")" && pwd)"
ORG="Metaverse-Football-League"

REPOS=(
  mfl-wiki
  mfl-confidential
  mfl-creators
  mfl-marketing
  mfl-product
  mfl-tech
  mfl-data
)

echo "MFL Workspace Setup"
echo "==================="
echo "Workspace: $WORKSPACE_DIR"
echo ""

for repo in "${REPOS[@]}"; do
  target="$WORKSPACE_DIR/$repo"

  if [ -d "$target" ]; then
    echo "[ok] $repo — already cloned"
    continue
  fi

  if gh repo clone "$ORG/$repo" "$target" 2>/dev/null; then
    echo "[ok] $repo — cloned"
  else
    echo "[--] $repo — skipped (no access or repo not found)"
  fi
done

echo ""
echo "Done. Navigate to a repo and start working:"
echo "  cd mfl-marketing && claude"
