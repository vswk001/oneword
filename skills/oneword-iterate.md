---
name: oneword-iterate
description: Applies an incremental change request to an existing OneWord-built application — updates requirements/design docs, implements via targeted TDD, re-verifies, updates README.
---

# OneWord Iterate - Incremental Modification

You are the master orchestrator for changes to an application that OneWord previously built. The user gives a short change request (e.g. "add CSV export", "switch to dark theme", "add a search box"). Apply it WITHOUT regenerating the project from scratch.

## Preconditions

- The current directory contains a working application with source code.
- `.oneword/` exists with pipeline artifacts (requirements.md, tech-stack.md, use-cases.md, design.md). If artifacts are missing, reconstruct only what the change needs (e.g. read the code instead of a missing design.md) — do not fail the whole iteration.

## Rules

- Do NOT ask the user questions. If the change is ambiguous, choose the smallest reasonable interpretation and state the assumption in your summary.
- Keep the tech stack. An iteration NEVER switches templates or frameworks.
- Preserve existing behavior and tests. You may only modify a test when the requested change legitimately changes that behavior.

## Process

### Step 1: Classify the Change

Read the change request and the existing artifacts. Classify it:

- **Type A — small/local**: touches 1-2 modules, no data model change. Skip to Step 3.
- **Type B — structural**: new feature with new data models / API routes / pages, or changes existing data model. Continue with Step 2.

### Step 2: Update Design Artifacts (Type B only)

1. Append the change to `.oneword/requirements.md` under a new heading `## Change Requests` as `CR-1: [description]` (or CR-n, incrementing).
2. Update `.oneword/use-cases.md`: add use cases for the new behavior (same UC-xx format, next free number), and revise any use case whose acceptance criteria changed.
3. Update `.oneword/design.md`: extend data models / API endpoints / component tree to cover the change. Keep changes additive and clearly scoped.

### Step 3: Implement with Targeted TDD

1. Write failing test(s) FIRST for the new/changed behavior — same conventions as the original build (test structure mirrors src/, naming `should <expected> when <condition>`).
2. Implement the minimum code to pass. Follow the Coding Standards from `oneword-code`.
3. Run the FULL existing test suite. If something unrelated breaks, fix the regression before proceeding — existing behavior is a contract.

### Step 4: Re-Verify

Run the quality gate exactly as defined in skill `oneword-verify` (locate → read → follow), including E2E if the change affects any user-facing path. Add or update E2E tests for the changed paths.

### Step 5: Update Progress & README

1. Append to `.oneword/progress.json`:
```json
{ "name": "iterate", "status": "completed", "change": "<user's change request>", "output": "src/ + tests/" }
```
2. Update the user-facing README.md to reflect the new/changed feature (plain language, user's language).

## Output

Tell the user (in their input language):
- What changed, in one sentence
- Which existing tests still pass (confirm nothing broke)
- The startup command (unchanged) if they want to try it
