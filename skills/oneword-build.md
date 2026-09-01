---
name: oneword-build
description: Transform a one-sentence requirement into a runnable application. Orchestrates the full software engineering pipeline automatically.
---

# OneWord Build - Master Orchestrator

You are the master orchestrator for OneWord. Your job is to take a user's one-sentence requirement and guide it through a complete software engineering pipeline, producing a high-quality, runnable application.

## Input

The user provides a single sentence describing what they want to build. This is the ONLY input from the user. Do NOT ask clarifying questions. Make all technical decisions yourself using best practices.

## How to Execute Sub-Skills

Do NOT use any platform-specific mechanism (Agent tool, subagent, plugin call) to run sub-skills — those are not portable. Instead, for each pipeline step:

1. **Locate the skill file.** Search these locations in order and use the first hit:
   - `skills/<skill-name>.md` relative to the current directory (repo checkout)
   - Platform skill directories: `~/.claude/skills/<skill-name>/SKILL.md`, `~/.agents/skills/<skill-name>/skill.md`, `.cursor/rules/<skill-name>.mdc`, `commands/<skill-name>.md` (on Windows, `~` is `%USERPROFILE%`)
2. **Read the file contents.**
3. **Follow its instructions exactly**, in the same conversation, one step at a time.

If a skill file cannot be found in any location, stop and tell the user: "OneWord skills are missing — please reinstall OneWord."

## Cross-Platform Commands

The user may be on macOS, Linux, or Windows. Before running shell commands:

- Prefer `npm run <script>` / `pip` / `npx` — these work identically everywhere.
- `mkdir -p .oneword/artifacts` → PowerShell: `New-Item -ItemType Directory -Force -Path .oneword/artifacts`
- `cp -r <src>/* .` → PowerShell: `Copy-Item -Recurse <src>\* .`
- `timeout 10 <cmd>` → PowerShell: `Start-Process` with timeout, or run the command in the background and stop it after 10 seconds. (Windows `timeout` is a pause command, NOT a timeout wrapper — never use it for this.)
- On Windows, run bash-style commands inside Git Bash if available.

## Language Rule

Detect the language of the user's input sentence. Pipeline-internal artifacts (requirements.md, tech-stack.md, use-cases.md, design.md, test-report.md) are written in English for reliability. The final README.md and the terminal summary MUST be written in the user's input language (e.g. Chinese input → Chinese README).

## Process

Execute the following steps IN ORDER. Complete each step before starting the next.

### Step 0: Initialize Workspace

Create `.oneword/artifacts/` and `.oneword/progress.json`:

```json
{
  "status": "running",
  "currentStep": 0,
  "totalSteps": 8,
  "input": "<user's original requirement>",
  "inputLanguage": "<language of the input, e.g. en / zh>",
  "steps": [],
  "retryCount": 0
}
```

### Step 1: Requirements Analysis

Execute skill `oneword-analyze` (locate → read → follow), passing the user's original requirement.

After completion, update progress.json: append `{"name": "analyze", "status": "completed", "output": ".oneword/requirements.md"}` and set `currentStep: 1`.

### Step 2: Tech Stack Selection

Execute skill `oneword-techstack`.

After completion, update progress.json with step 2 status (output: `.oneword/tech-stack.md`).

### Step 3: Use Case Design

Execute skill `oneword-usecases`.

After completion, update progress.json with step 3 status (output: `.oneword/use-cases.md`).

### Step 4: Detailed Design

Execute skill `oneword-design`.

After completion, update progress.json with step 4 status (output: `.oneword/design.md`).

### Step 5: Code Implementation (TDD)

Execute skill `oneword-code`.

After completion, update progress.json with step 5 status (outputs: `src/`, `tests/unit/`, `tests/integration/`).

### Step 6: End-to-End Testing

Execute skill `oneword-e2e`.

After completion, update progress.json with step 6 status (output: `tests/e2e/`).

### Step 7: Verification & Quality Gate

Execute skill `oneword-verify`.

**Retry semantics (two layers, do not mix them):**

- **Layer 1 — inside verify (test-level failures):** `oneword-verify` already runs its own auto-fix loop (max 3 rounds) for compilation errors, logic errors, broken tests, and missing dependencies. Do not re-run verify for these.
- **Layer 2 — orchestrator (structural failures only):** if verify's test-report still says FAILED AND the remaining issues are structural (missing module, wrong architecture, feature not implemented), increment `retryCount` in progress.json (max 1), re-execute skill `oneword-code` in **fix mode** (defined in that skill), then re-execute `oneword-verify` once. If it still fails, go to Error Handling.

After completion, update progress.json with step 7 status (output: `.oneword/test-report.md`).

### Step 8: Delivery

Execute skill `oneword-deliver`.

After completion, update progress.json: `{ "status": "completed", "currentStep": 8 }`.

## Error Handling

- If a documentation step (analyze, usecases, design) fails: retry it ONCE. If it still fails, set `status: "failed"` and stop.
- If verify fails after both retry layers: set `status: "failed"`, write `.oneword/diagnosis.md` (template below), and stop.
- Never ask the user for input during the pipeline. Make all decisions autonomously.
- On any failure, tell the user they can fix the environment (`/oneword-doctor`) or resume later (`/oneword-resume`).

### diagnosis.md template

```markdown
# Build Failure Diagnosis

## Where It Stopped
[Step name + the failing command or instruction]

## What Went Wrong
[Plain-language explanation, in the user's input language]

## Evidence
[Key error messages]

## Suggested Next Steps
[2-3 concrete options: fix environment, resume, or report issue]
```

## Output

After successful completion, display to the user (in their input language):
- A one-sentence summary of what was built
- The startup command (e.g., "Run `npm install && npm start` to launch your app")
- A brief list of implemented features in plain language
- A hint that they can iterate: "Want changes? Just tell me — e.g. `/oneword-iterate add CSV export`"
