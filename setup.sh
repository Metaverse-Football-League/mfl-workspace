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

# Make general-purpose skills available globally
SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

declare -A SKILL_SOURCES=(
  [commit]="$WORKSPACE_DIR/.claude/skills/commit"
  [agent-browser]="$WORKSPACE_DIR/.claude/skills/agent-browser"
  [email]="$WORKSPACE_DIR/mfl-creators/.claude/skills/email"
  [project-create]="$WORKSPACE_DIR/.claude/skills/project-create"
)

for skill in "${!SKILL_SOURCES[@]}"; do
  target="$SKILLS_DIR/$skill"
  if [ ! -e "$target" ] && [ ! -L "$target" ]; then
    ln -s "${SKILL_SOURCES[$skill]}" "$target"
    echo "[ok] $skill skill — symlinked to global"
  else
    echo "[ok] $skill skill — already available globally"
  fi
done

echo ""
echo "Done. Navigate to a repo and start working:"
echo "  cd mfl-marketing && claude"
