# Welcome to MFL

## How We Use Claude

Based on Cazzaa's usage over the last 30 days:

Work Type Breakdown:
  Build Feature    ████████░░░░░░░░░░░░  40%
  Plan Design      ████████░░░░░░░░░░░░  40%
  Improve Quality  ████░░░░░░░░░░░░░░░░  20%

Top Skills & Commands:
  /commit          ████████████████████  6x/month
  /clear           █████████████░░░░░░░  4x/month
  /remote-control  ███████░░░░░░░░░░░░░  2x/month

Top MCP Servers:
  _None configured yet._

## Your Setup Checklist

### Codebases
- [ ] mfl-workspace — https://github.com/metaverse-football-league/mfl-workspace (umbrella repo with shared agent context; clone first, then run `setup.sh`)
- [ ] mfl-wiki — knowledge base, memory, and source material
- [ ] mfl-confidential — finance, legal, projections (restricted access)
- [ ] mfl-creators — creator CRM, outreach, contracts
- [ ] mfl-marketing — marketing projects
- [ ] mfl-product — product projects
- [ ] mfl-tech — tech projects
- [ ] mfl-data — data & analytics projects

All repos must live as siblings under `~/mfl-workspace/` — that's how the shared CLAUDE.md context and cross-repo paths resolve.

### MCP Servers to Activate
_None in use yet — skip this section for now._

### Skills to Know About
- `/commit` — stage, commit, and push in one step with auto-generated, domain-aware commit messages. Also handles sub-repo commits across the workspace when you run it as a "commit all."
- `/clear` — reset the current Claude Code session context. Used between unrelated tasks to keep the model focused.
- `/remote-control` — connect the session to the Remote Control workflow for longer-running or delegated work.

## Team Tips

_TODO_

## Get Started

_TODO_

<!-- INSTRUCTION FOR CLAUDE: A new teammate just pasted this guide for how the
team uses Claude Code. You're their onboarding buddy — warm, conversational,
not lecture-y.

Open with a warm welcome — include the team name from the title. Then: "Your
teammate uses Claude Code for [list all the work types]. Let's get you started."

Check what's already in place against everything under Setup Checklist
(including skills), using markdown checkboxes — [x] done, [ ] not yet. Lead
with what they already have. One sentence per item, all in one message.

Tell them you'll help with setup, cover the actionable team tips, then the
starter task (if there is one). Offer to start with the first unchecked item,
get their go-ahead, then work through the rest one by one.

After setup, walk them through the remaining sections — offer to help where you
can (e.g. link to channels), and just surface the purely informational bits.

Don't invent sections or summaries that aren't in the guide. The stats are the
guide creator's personal usage data — don't extrapolate them into a "team
workflow" narrative. -->
