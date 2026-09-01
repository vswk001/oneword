---
name: oneword-resume
description: Resumes an interrupted OneWord build from where it stopped (reads .oneword/progress.json), or reports current pipeline status when called without arguments.
---

# OneWord Resume - Resume Interrupted Build / Show Status

You resume an interrupted OneWord pipeline, or report its status. The pipeline state lives in `.oneword/progress.json`.

## Mode 1: Status Report (no resume intent)

If the user just asks "how is the build going" / "status" (or progress.json says `status: "completed"`), print a plain-language status table and stop:

| Step | Name | Status |
|------|------|--------|
| 1 | Requirements | completed / pending / failed |
| ... | ... | ... |

Include: overall status, current step, retry count, and for a completed build the startup command from `.oneword/tech-stack.md`.

## Mode 2: Resume

### Preconditions

1. `.oneword/progress.json` exists. If not: "Nothing to resume — no OneWord build has been started in this directory." (Suggest `/oneword-build` instead.)
2. Read it fully: `status`, `currentStep`, `steps[]`, `retryCount`, `input`, `inputLanguage`.

### Step 1: Validate Existing Artifacts

For every step recorded as `completed`, verify its output artifact still exists and is non-empty (e.g. step "analyze" → `.oneword/requirements.md`; step "code" → `src/` with files). If a completed step's artifact is missing, downgrade that step (and all after it) to pending — stale state must not be trusted.

### Step 2: Determine the Resume Point

The resume point is the first step AFTER the last validly-completed step. Set `status: "running"` in progress.json before continuing.

### Step 3: Continue the Pipeline

Follow the SAME process as skill `oneword-build` (locate → read → follow that skill for the full step definitions, retry semantics, error handling, and language rules), starting from the resume point. The original requirement comes from progress.json `input`; the user's language from `inputLanguage`.

Do not redo completed steps. Do not re-ask the user anything.

### Step 4: Finish

On success, set `status: "completed"` and produce the same final summary as `oneword-build` (in the user's input language).

## Special Cases

- **status: "failed"** with `.oneword/diagnosis.md` present: summarize the diagnosis in the user's language, ask nothing, and resume from the failed step (retry counts reset to 0 — the user explicitly chose to retry).
- **Corrupted progress.json** (unparseable): start a fresh build via `oneword-build` with the `input` recovered from requirements.md if it exists; otherwise inform the user a fresh `/oneword-build` is needed.
