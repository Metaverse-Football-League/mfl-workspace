# MFL Workspace — Shared Agent Context

> This file is automatically loaded by Claude Code for any repo inside `~/mfl-workspace/`.
> It provides the shared context (red lines, terminology) that every agent inherits.

---

## What is MFL?

MFL (Metaverse Football League) is a football management simulation — more than a game, a parallel football universe. True ownership, a real economy, and multiplayer competition against real humans. Football fans become club owners: scout players, set tactics, compete in seasons.

---

## Red Lines (Always Enforced)

- **Never position MFL as investment** — no "you can make money" or "guaranteed returns." MFL is a game.
- **18+ restriction is strict** — real-money economy requires it.
- **Don't overpromise features** — only discuss what is officially announced.
- **Be careful with economic claims** — verify against KB source files.
- **Never invent facts** — accuracy first. If unsure, say so.
- **English only** — all files, commit messages, and documentation must be in English.

---

## Critical Terminology

| Use | Avoid | Why |
|-----|-------|-----|
| Club owner | NFT holder | Football, not crypto |
| Player | Asset | Human, not transactional |
| $MFL | Tokens | Currency, not speculation |
| Manager | User | Role-play the fantasy |

---

## Workspace Structure

This workspace is an umbrella containing multiple independent Git repos. Each sub-folder is its own repo, cloned via `setup.sh`.

```
mfl-workspace/                         ← This repo (shared context)
├── mfl-wiki/                          ← Knowledge system (KB + memory + sources)
├── mfl-confidential/                  ← Finance, legal, projections (restricted)
├── mfl-creators/                      ← Creator CRM, outreach, contracts
├── mfl-marketing/                     ← Marketing projects
├── mfl-product/                       ← Product projects
├── mfl-tech/                          ← Tech projects
└── mfl-data/                          ← Data & analytics projects
```

For the full repo catalog with access levels, see `INDEX.md`.

### Cross-repo references

When a skill or CLAUDE.md references another repo, it uses relative paths from the workspace root (e.g., `../mfl-wiki/knowledge-base/09-marketing/`). These paths work because all repos are siblings under `~/mfl-workspace/`.

**Important**: All repos must be cloned inside `~/mfl-workspace/` for the cascade and cross-references to work. Cloning a repo elsewhere loses the shared context.

---

## Shared Conventions

- Accuracy first — never invent facts
- Lead with football passion, not crypto/blockchain
- Emphasize human competition as key differentiator

---

## Quick Reference

| Field | Value |
|-------|-------|
| **Company** | MFL (Metaverse Football League) |
| **Product** | Football management simulation |
| **Website** | playmfl.com |
| **Founded** | Nov 2021 (Paris, France) |
| **Team Size** | ~7 people |
| **Age Restriction** | 18+ only |
