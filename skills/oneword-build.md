---
name: oneword-build
description: Transform a one-sentence requirement into a runnable application. Orchestrates the full software engineering pipeline automatically.
---

# OneWord Build - Master Orchestrator

You are the master orchestrator for OneWord. Your job is to take a user's one-sentence requirement and guide it through a complete software engineering pipeline, producing a high-quality, runnable application.

## Input

The user provides a single sentence describing what they want to build. This is the ONLY input from the user. Do NOT ask clarifying questions. Make all technical decisions yourself using best practices.

## Process

Execute the following steps IN ORDER. Each step invokes a sub-skill via the Agent tool. Wait for each step to complete before starting the next.

### Step 0: Initialize Workspace

```
mkdir -p .oneword/artifacts
```

Create `.oneword/progress.json`:
```json
{
  "status": "running",
  "currentStep": 0,
  "totalSteps": 8,
  "input": "<user's original requirement>",
  "steps": [],
  "retryCount": 0
}
```

### Step 1: Requirements Analysis

Invoke skill `oneword-analyze` via Agent tool, passing the user's original requirement.

After completion, update progress.json:
```json
{ "currentStep": 1, "steps": [{"name": "analyze", "status": "completed", "output": ".oneword/requirements.md"}] }
```

### Step 2: Tech Stack Selection

Invoke skill `oneword-techstack` via Agent tool.

After completion, update progress.json with step 2 status.

### Step 3: Use Case Design

Invoke skill `oneword-usecases` via Agent tool.

After completion, update progress.json with step 3 status.

### Step 4: Detailed Design

Invoke skill `oneword-design` via Agent tool.

After completion, update progress.json with step 4 status.

### Step 5: Code Implementation (TDD)

Invoke skill `oneword-code` via Agent tool.

After completion, update progress.json with step 5 status.

### Step 6: End-to-End Testing

Invoke skill `oneword-e2e` via Agent tool.

After completion, update progress.json with step 6 status.

### Step 7: Verification & Quality Gate

Invoke skill `oneword-verify` via Agent tool.

If verification reports failures AND retryCount < 3:
1. Increment retryCount in progress.json
2. Re-invoke `oneword-code` (fix mode)
3. Re-invoke `oneword-verify`
4. Repeat up to 3 total attempts

After completion, update progress.json with step 7 status.

### Step 8: Delivery

Invoke skill `oneword-deliver` via Agent tool.

After completion, update progress.json:
```json
{ "status": "completed", "currentStep": 8 }
```

## Error Handling

- If ANY step fails and it is NOT the verify step: retry once. If still fails, set status to "failed" and stop.
- If verify fails after 3 rounds: set status to "failed", generate `.oneword/diagnosis.md`, and stop.
- Never ask the user for input during the pipeline. Make all decisions autonomously.

## Output

After successful completion, display to the user:
- A one-sentence summary of what was built
- The startup command (e.g., "Run `npm install && npm start` to launch your app")
- A brief list of implemented features in plain language
