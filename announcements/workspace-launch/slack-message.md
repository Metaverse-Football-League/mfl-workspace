# MFL Workspace — Team Announcement (Slack / Discord)

> Short message to post in #general (or equivalent). Full guide and infographic attached.

---

**Hey team — new repo to bookmark: `mfl-workspace` (it replaces `mfl-knowledge-base`).** :rocket:

`mfl-workspace` is the new umbrella home for all our repos. Once cloned, it sits at `~/mfl-workspace/` and holds every domain-specific repo as a sibling folder: `mfl-wiki`, `mfl-marketing`, `mfl-product`, `mfl-tech`, `mfl-data`, `mfl-creators`, and `mfl-confidential`. The magic: Claude Code automatically loads the workspace-level `CLAUDE.md` (red lines, terminology, conventions) on top of any domain-specific instructions — so every agent across the company speaks the same MFL language, no config needed.

**To get started:** clone the repo into your home folder and run `./setup.sh`. The script pulls every sub-repo you have access to and silently skips the ones you don't. Then just `cd` into any domain folder (e.g. `mfl-marketing/`) and run `claude`. Shared skills like `/commit` and `/project-create` work everywhere; domain-specific skills (`/creator-outreach`, `/meta-ads`, `/data-cohort-update`, etc.) live in their own repo and load automatically.

**About `mfl-wiki` specifically** — this is our new knowledge system, structured in three layers: `knowledge-base/` (curated pages organized by domain — e.g. `09-marketing/`), `sources/` (raw imported material: docs, transcripts, articles), and `memory/` (long-term context agents can draw from). Feeding it is a three-step flow: `/source-import` pulls raw material in, `/wiki-ingest` curates it into the KB, and `/wiki-update` evolves existing pages. `/wiki-recap` gives you a quick digest of what's changed.

Full guide :page_facing_up: + infographic :framed_picture: attached below. Ping me if anything is unclear or if you hit setup issues. :soccer:
