---
name: project-create
description: Create a new operational project in a domain folder. Use when the user runs /project-create or asks to start a new project.
argument-hint: "{domain} {project-name}"
---

# Project Create Skill

## Usage

`/project-create {domain} {project-name}`

Example: `/project-create marketing world-cup-campaign`

## Workflow

1. **Parse arguments** — extract domain and project name
2. **Validate domain** — must be one of: marketing, product, tech, data
3. **Validate project name** — kebab-case, no spaces
4. **Check project doesn't already exist** — `../mfl-{domain}/{project-name}/` must not exist
5. **Ask for details** (if not provided):
   - One-line objective
   - Associated Discord channel(s) (default: #{domain})
   - Owner (default: user)
6. **Create project folder** in the domain repo:
   - `../mfl-{domain}/{project-name}/README.md` with:
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
7. **Add entry to `PROJECTS.md`** in the workspace root — append row to the table (use `mfl-{domain}` as the Repo column)
8. **Commit** with message: `{domain}: Create {project-name} project`

## Rules

- Project names must be kebab-case
- One folder per project, always under a domain
- README.md is the minimum viable project — additional files added as needed
- Auto-commit after creation
