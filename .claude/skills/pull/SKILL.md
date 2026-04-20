---
name: pull
description: >
  Pull latest changes from remote for the current repo. Use when the user runs /pull,
  or says "pull", "pull latest", "update repo", "sync repo", or any variant.
  With --all: pull all sub-repos in the workspace. Also triggers on "pull everything",
  "pull all repos", "sync all", "update all repos". Argument: [--all].
---

# Pull Skill

Fetch and pull latest changes from remote for the current repo, or all workspace sub-repos.

## Invocation

- `/pull` — pull the current repo only
- `/pull --all` — pull the current repo **and** all sub-repos. **Only works from workspace root** (`mfl-workspace/`).
- "pull latest" / "update repo" / "sync repo"
- "pull all repos" / "sync all" / "update all repos"

## Workflow

### Phase 1: Pre-flight Checks

1. Run `git status` to check for uncommitted changes.
   - If there are **uncommitted changes**, warn: "You have uncommitted changes. Pull may cause merge conflicts. Consider committing or stashing first." but **do not block** — proceed unless the user cancels.

2. Identify the current branch with `git branch --show-current`.

3. Check if the branch has an upstream with `git rev-parse --abbrev-ref @{upstream} 2>/dev/null`.
   - If **no upstream**: report "No upstream branch set for `[branch]`. Nothing to pull." and stop.

### Phase 2: Pull

4. Run `git pull` on the current repo.

5. If pull fails due to **merge conflict**:
   - Report the conflicting files.
   - Do NOT attempt to resolve automatically. Suggest: "Resolve conflicts manually, then `git add` and `git commit`."
   - Stop processing this repo (but continue to next sub-repo if `--all`).

6. If pull fails for **any other reason** (auth, network, etc.), report the error and stop for this repo.

### Phase 2b: Sub-repo Pulls (`--all` only)

This phase runs **only** when `--all` is passed **and** the current working directory is the workspace root (`mfl-workspace/`).

7. **Discover sub-repos**: List all immediate child directories that contain a `.git` folder.

8. **For each sub-repo**, repeat Phases 1–2 scoped to that repo:
   a. `cd` into the sub-repo.
   b. Run `git status` to check for uncommitted changes (warn if dirty, don't block).
   c. Check branch and upstream.
   d. Run `git pull`.
   e. Report result (success, already up-to-date, conflict, or error).

9. **Important constraints**:
   - If a sub-repo pull fails, report the error for that repo and **continue to the next**. Don't abort the whole run.
   - The workspace root is always pulled first, then sub-repos in alphabetical order.

### Phase 3: Summary

10. Print a clean summary.

For `--all` runs:

```
Pulled all repos.

  mfl-workspace/
    Branch: main · Already up to date

  mfl-creators/
    Branch: main · Updated (3 commits)

  mfl-wiki/
    Branch: main · Already up to date

  mfl-marketing/
    Branch: feat/campaign · CONFLICT — resolve manually
```

For single-repo pulls:

```
Pulled.

  Branch: [branch-name]
  [Already up to date | Updated (N commits) | CONFLICT | Error: ...]
```

## Error Handling

- **No upstream**: Report and stop for that repo.
- **Merge conflict**: Report conflicting files, suggest manual resolution, continue to next repo if `--all`.
- **Network/auth error**: Report and stop for that repo.
- **Dirty working tree**: Warn but proceed.
- **Detached HEAD**: Warn and skip. Suggest checking out a branch first.
