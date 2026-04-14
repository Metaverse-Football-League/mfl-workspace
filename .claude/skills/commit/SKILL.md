---
name: commit
description: >
  Stage, commit, and push changes in one step. Auto-generates domain-aware commit messages
  following repo conventions. Use when the user runs /commit, or says "commit and push",
  "commit & push", "commit this", "push it", or any variant. Also triggers on common typos
  like "comit and push", "comit & push".
argument-hint: "[optional: -m 'message' | --no-push | --all]"
---

# Commit Skill

Stage all changes, generate a well-formatted commit message, commit, and push — all in one command.

## Invocation

- `/commit` — stage session files, commit with auto-generated message, and push
- `/commit --all` — stage ALL dirty files (not just session), commit, and push. **In workspace root**: also iterates through all sub-repo folders and commits their changes individually.
- `/commit -m "message"` — use the provided message instead of auto-generating
- `/commit --no-push` — commit only, skip pushing
- "commit and push" / "commit & push" / "commit this" / "push it"

## Workflow

### Phase 1: Assess Changes

1. Run `git status` (never use `-uall` flag) to identify:
   - Staged changes
   - Unstaged modifications
   - Untracked files

2. Run `git diff` and `git diff --staged` to understand what changed.

3. Run `git log --oneline -5` to see recent commit message style.

4. If there are **no changes** (clean working tree), report "Nothing to commit." and stop.

5. **Build session file set** (skip if `--all`): Review the current conversation for files created or modified by tool calls (Edit, Write, or Bash commands that wrote files). This is the set of files this session is responsible for. Only these files will be staged by default.

### Phase 2: Safety Checks

6. Check all changed/untracked files for risks:
   - **Sensitive files**: `.env`, `credentials.json`, `*.key`, `*.pem`, tokens, secrets — **WARN and exclude** from staging
   - **Large binaries**: files > 5MB or binary formats (`.zip`, `.tar`, `.mp4`, etc.) — **WARN and ask** before including
   - **DS_Store / system files**: `.DS_Store`, `Thumbs.db` — **silently exclude**

7. If on `main` branch with 10+ files changed, suggest creating a branch first (but don't block — just mention it).

### Phase 3: Generate Commit Message

8. If the user provided `-m "message"`, use that message as-is (still append co-author).

9. Otherwise, **auto-detect domain** from the changed file paths:

   | Changed files in... | Domain | Message format |
   |---------------------|--------|----------------|
   | `creators-management/creators/<slug>/` | Creator (single) | `Update [Name]: [change summary]` |
   | `creators-management/creators/` (multiple slugs) | Creator (multi) | `Update [N] creators ([Mon DD]): [brief list]` |
   | `creators-management/dashboard.md` | Creator + dashboard | Include "dashboard updated" in message |
   | `knowledge-base/` | KB | `KB: [Add\|Update] path/file.md - reason` |
   | `.claude/skills/` | Skill | `[Add\|Update\|Fix] [skill-name] skill` |
   | Mixed domains | General | Concise summary of all changes |

10. **Creator domain specifics:**
   - Single creator: extract the creator name from the folder name (e.g., `flyndle/` → "Flyndle")
   - Summarize what changed: "contract sent", "stats refreshed", "new profile", "touchpoint added"
   - Include today's date in parentheses for multi-creator updates
   - If dashboard.md also changed, append that to the message

11. **KB domain specifics:**
    - Use the file path relative to `knowledge-base/`
    - Prefix with `KB: Add` for new files, `KB: Update` for modifications

12. Keep the message under 72 characters for the first line. Add detail in the body if needed.

### Phase 4: Stage and Commit

13. Stage files using `git add` with **specific file paths** (never `git add -A` or `git add .`).
    - Exclude any files flagged in Phase 2 (sensitive, system files)
    - **Default (session-scoped):** Only stage files from the session file set (step 5). If none of the session files appear in the dirty working tree, warn: "No session-modified files found among dirty files. Use `/commit --all` to stage everything." and stop.
    - **`--all` flag:** Stage all changed and untracked files (old behavior)

14. Commit using a HEREDOC for proper formatting:
    ```bash
    git commit -m "$(cat <<'EOF'
    [Generated or user-provided message]

    Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
    EOF
    )"
    ```

15. If the commit fails (e.g., pre-commit hook), diagnose the issue and fix it. Then create a **new** commit (never amend).

### Phase 5: Push

16. **Skip this phase** if `--no-push` was passed.

17. Check if the current branch has an upstream:
    - If yes: `git push`
    - If no: `git push -u origin [branch-name]`

18. If push fails (e.g., rejected because remote is ahead), report the error. Do NOT force push. Suggest `git pull --rebase` instead.

### Phase 5b: Sub-repo Commits (workspace `--all` only)

This phase runs **only** when `--all` is passed **and** the current working directory is the workspace root (`mfl-workspace/`).

19. **Discover sub-repos**: List all immediate child directories that contain a `.git` folder. These are independent repos (e.g., `mfl-wiki/`, `mfl-marketing/`, `mfl-creators/`).

20. **For each sub-repo with dirty changes**, repeat Phases 1–5 scoped to that repo:
    a. `cd` into the sub-repo and run `git status` / `git diff`.
    b. If the working tree is clean, skip it silently.
    c. Run all safety checks (Phase 2) — same rules apply.
    d. Auto-generate a commit message using the same domain detection logic (Phase 3), but scoped to that repo's changes.
    e. Stage files with specific paths (Phase 4) — never `git add -A` or `git add .`.
    f. Commit with HEREDOC + co-author line.
    g. Push (Phase 5) unless `--no-push` was passed.

21. **Important constraints for sub-repo commits**:
    - Each sub-repo gets its own independent commit with its own message.
    - Never combine changes from multiple sub-repos into one commit.
    - If a sub-repo commit or push fails, report the error for that repo and continue to the next. Don't abort the whole run.
    - The workspace root is always committed first, then sub-repos in alphabetical order.

### Phase 6: Summary

22. Print a clean summary. For workspace `--all` runs, list each repo that was committed:

```
Committed and pushed.

  mfl-workspace/
    [short-hash] [commit message first line]
    Branch: [branch-name] · Files: [N] changed · Pushed

  mfl-creators/
    [short-hash] [commit message first line]
    Branch: [branch-name] · Files: [N] changed · Pushed

  mfl-wiki/
    (clean — nothing to commit)
```

For single-repo commits (no sub-repo phase):
```
Committed and pushed.

  [short-hash] [commit message first line]
  Branch: [branch-name]
  Files: [N] changed
  Remote: pushed to origin/[branch-name]
```

If `--no-push`:
```
Committed (not pushed).

  [short-hash] [commit message first line]
  Branch: [branch-name]
  Files: [N] changed
```

## Error Handling

- **Nothing to commit**: Report and stop. Don't create empty commits.
- **Sensitive file detected**: Warn explicitly, exclude from staging, continue with remaining files.
- **Push rejected**: Report error, suggest `git pull --rebase`, do NOT force push.
- **Commit hook failure**: Fix the issue, stage again, create a NEW commit (never `--amend`).
- **Detached HEAD**: Warn and stop. Suggest checking out a branch first.

## Notes

- **Session-scoped by default**: `/commit` only stages files that the current conversation touched (via Edit, Write, or Bash). This prevents one terminal from accidentally committing another terminal's in-progress work. Use `--all` to stage everything.
- This skill **never** uses `git add -A`, `git add .`, `--force`, `--no-verify`, or `--amend`.
- The co-author line is always appended. It cannot be disabled.
- This skill does not create branches. Use `git checkout -b` separately if needed.
- For KB changes that should go through PR review, use `/wiki-update` instead.
