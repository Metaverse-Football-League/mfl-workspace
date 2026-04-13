# MFL Workspace

Umbrella workspace for the MFL (Metaverse Football League) ecosystem. Contains multiple independent Git repos organized under one directory, with shared context loaded automatically by Claude Code.

## Quick Start

```bash
git clone https://github.com/Metaverse-Football-League/mfl-workspace.git ~/mfl-workspace
cd ~/mfl-workspace
chmod +x setup.sh
./setup.sh
```

This clones all repos you have access to. Repos you don't have access to are skipped silently.

## Working with Claude Code

Navigate to any sub-repo and launch Claude:

```bash
cd mfl-marketing && claude
```

Claude Code automatically loads the workspace `CLAUDE.md` (red lines, terminology) plus the domain-specific `CLAUDE.md` from the sub-repo. No configuration needed.

## Repo Overview

See `INDEX.md` for the full catalog with access levels and available skills.

| Repo | What it contains |
|------|-----------------|
| `mfl-wiki/` | Knowledge base, memory, raw sources |
| `mfl-confidential/` | Finance, legal, projections (restricted) |
| `mfl-creators/` | Creator CRM and partnership management |
| `mfl-marketing/` | Marketing projects |
| `mfl-product/` | Product projects |
| `mfl-tech/` | Tech projects |
| `mfl-data/` | Data & analytics projects |

## Important

All repos must be cloned inside this workspace directory for cross-repo references and the CLAUDE.md cascade to work. Do not clone repos to a different location.
