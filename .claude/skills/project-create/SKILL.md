---
name: project-create
description: Create a new operational project in a domain folder. Use when the user runs /project-create or asks to start a new project.
argument-hint: "{domain} {project-name}"
---

# Project Create Skill

Creates operational projects in a whitelisted MFL workspace sub-repo. This skill is strictly scoped to those sub-repos. It does **not** create anything in `my-assistant/` — that folder is confidential/personal and managed by the user directly.

## Usage

`/project-create {domain} {project-name}`

Example: `/project-create marketing world-cup-campaign`

## Allowed domains (whitelist)

Only these domains are accepted:

- `marketing` → `mfl-marketing`
- `product` → `mfl-product`
- `tech` → `mfl-tech`
- `data` → `mfl-data`
- `wiki` → `mfl-wiki`
- `confidential` → `mfl-confidential`

Any other value (e.g., `accounting`, `legal`, `sales`, `finance`) must be **rejected**. The user must explicitly say they want to add a new repo to the workspace (e.g., "add mfl-finance as a new workspace repo") before the whitelist can be expanded. Do not silently create in a non-whitelisted domain, do not redirect to `my-assistant/`, do not invent a location.

## Where projects are tracked

Each sub-repo owns its own `PROJECTS.md` index at its root. Sub-repos live **inside** `mfl-workspace/` (not as siblings of `my-assistant/`). From the typical working directory `/Users/mathurin/MFL/my-assistant/`, the path is `../mfl-workspace/mfl-{domain}/PROJECTS.md`.

The skill appends to the index inside the relevant sub-repo. There is **no** global `PROJECTS.md` in `mfl-workspace/` anymore.

If a sub-repo has no `PROJECTS.md` yet, create one with this header:

```markdown
# Projects — mfl-{domain}

Active projects in this repo.

| Project | Discord Channel(s) | Owner | Status | Created |
|---------|---------------------|-------|--------|---------|
```

## Workflow

1. **Parse arguments** — extract domain and project name.
2. **Validate domain against the whitelist above.**
   - If not whitelisted → stop and reply: *"`{domain}` is not a whitelisted workspace domain. Allowed: marketing, product, tech, data, wiki, confidential. If you want to add a new repo to mfl-workspace, say so explicitly and I'll set it up."*
   - Do not proceed until the user either picks a whitelisted domain or explicitly authorizes adding a new workspace repo.
3. **Validate project name** — kebab-case, no spaces.
4. **Check project doesn't already exist** at `../mfl-workspace/mfl-{domain}/{project-name}/`.
5. **Ask for details** (if not provided):
   - One-line objective
   - Associated Discord channel(s) (default: `#{domain}`)
   - Owner (default: user)
6. **Create project folder** at `../mfl-workspace/mfl-{domain}/{project-name}/README.md`:
   ```markdown
   # {Project Name}

   > {One-line objective}

   | Field | Value |
   |-------|-------|
   | **Domain** | {domain} |
   | **Discord** | {channels} |
   | **Owner** | {owner} |
   | **Created** | {YYYY-MM-DD} |
   | **Status** | Active |
   ```
7. **Append a row to `../mfl-workspace/mfl-{domain}/PROJECTS.md`** (creating the file with the header above if it doesn't exist yet). Do not touch `mfl-workspace/PROJECTS.md` — it should no longer exist as a global index.
8. **Do not commit** — user will commit manually when ready.

## Rules

- `my-assistant/` is confidential. **Never** list anything from `my-assistant/` in any `PROJECTS.md`, and never create projects there via this skill.
- Whitelist enforcement is strict. Expanding the whitelist requires an explicit user instruction to add a new workspace repo — not an inferred intent from the arguments.
- Project indexes live per sub-repo (`../mfl-workspace/mfl-{domain}/PROJECTS.md`), not globally.
- Project names must be kebab-case.
- `README.md` is the minimum viable project — additional files added as needed.
