---
name: oneword-verify
description: Runs all tests, lint, build, startup and security checks, auto-fixes test-level failures in a retry loop (max 3 rounds), produces a test report with an explicit PASS/FAIL verdict.
---

# OneWord Verify - Test Verification & Quality Gate

You are a QA automation engineer. Run the complete test suite and quality checks, fix any issues found.

## Input

Read `.oneword/tech-stack.md` — use the exact commands from its **Commands** section.

## Quality Gate Thresholds

Read `~/.oneword/config/default-pipeline.yaml` (Windows: `%USERPROFILE%\.oneword\config\default-pipeline.yaml`) if it exists and use its `quality_gates`. Otherwise use these defaults:

- test_pass_rate: 100% (every test must pass)
- test_coverage_min: 80% (where coverage is measurable)
- lint_pass: true
- build_pass: true
- startup_pass: true

**The overall verdict is FAILED if ANY of:** a test fails, lint fails, build fails, startup fails, or coverage is below the threshold when measurable. Coverage is N/A (does not fail the gate) only when the stack has no coverage tooling configured.

## Quality Checklist

Execute each check IN ORDER:

### 1. Install Dependencies
```bash
npm install  # or: pip install -r requirements.txt
```
If this fails, diagnose and fix the dependency issue.

### 2. Lint
```bash
npm run lint  # or: ruff check src/
```
If lint errors exist, fix them.

### 3. Build
```bash
npm run build  # or: cd frontend && npm run build
```
If build fails, diagnose and fix.

### 4. Unit & Integration Tests
```bash
npm test  # or: pytest --cov=src tests/
```
Collect: total tests, passed, failed, coverage percentage.

### 5. E2E Tests (web templates only; skip for CLI-only apps)

First, make sure Playwright browsers are installed — on a fresh machine `npx playwright test` fails with a confusing error if they are not:
```bash
npx playwright install chromium
```

Then run:
```bash
npx playwright test
```
Collect: total E2E tests, passed, failed.

### 6. Startup Verification

Start the application and verify it responds without crashing. Give it up to 10 seconds, then stop it:

- bash: `timeout 10 npm start` (or the start command + `curl http://localhost:<port>/api/health`)
- PowerShell: start the process in the background, poll the health URL for up to 10 seconds, then stop the process. Do NOT use Windows `timeout` — it is a pause command, not a timeout wrapper.

Success = process starts, listens, and the health endpoint (or root page) responds.

### 7. Security Checks

- **Dependency audit** (Node templates): `npm audit --audit-level=high` — treat HIGH or CRITICAL advisories as failures; fix by upgrading the offending dependency.
- **Hardcoded secrets**: scan `src/` for API keys, passwords, tokens committed in code (patterns like `sk-`, `AKIA`, `password =`, long hex/base64 literals assigned to SECRET/KEY/TOKEN-named variables). Findings are failures; move values to `.env` and read from environment.
- **`.env` must not be committed**: verify `.env` is listed in `.gitignore` (the templates ship this way; only a failure if it was removed).
- **Bind to localhost by default**: generated servers must listen on 127.0.0.1/localhost unless the requirement explicitly says otherwise.

## Auto-Fix Loop (test-level failures)

If any test fails:
1. Read the failing test output carefully
2. Categorize the failure: compilation error | logic error | test itself is wrong | missing dependency
3. Fix the source code (or test if the test is wrong)
4. Re-run the failing tests
5. Repeat up to 3 rounds total

If all tests pass before 3 rounds, proceed to output immediately.

Scope note: this loop handles test-level failures only. Structural failures (missing modules, unimplemented features) must be reported in "Remaining Issues" — the orchestrator decides whether to re-run `oneword-code` in fix mode.

## Output

Write the result to `.oneword/test-report.md`:

```markdown
# Test Report: [Project Name]

## Summary
- **Status**: PASSED / FAILED
- **Total Tests**: [N]
- **Passed**: [N]
- **Failed**: [N]
- **Coverage**: [N]% (or "N/A — no coverage tooling")
- **Lint**: PASS / FAIL
- **Build**: PASS / FAIL
- **Startup**: PASS / FAIL
- **Security Audit**: PASS / FAIL (details below)

## Gate Evaluation
| Gate | Threshold | Actual | Result |
|------|-----------|--------|--------|
| Test pass rate | 100% | [x]% | PASS/FAIL |
| Coverage | >= 80% | [x]% or N/A | PASS/FAIL/N/A |
| Lint | pass | pass/fail | PASS/FAIL |
| Build | pass | pass/fail | PASS/FAIL |
| Startup | pass | pass/fail | PASS/FAIL |
| Security | no high findings | [n] findings | PASS/FAIL |

## Test Results

### Unit Tests
[Detailed pass/fail per test file]

### Integration Tests
[Detailed pass/fail per test file]

### E2E Tests
[Detailed pass/fail per test file, or "skipped — CLI application"]

## Security Findings
[Audit result, secrets scan result, .env check result]

## Issues Found & Fixed
[List of issues found during verification and how they were fixed]

## Remaining Issues (if any)
[Issues that could not be fixed within 3 rounds. Mark each as TEST-LEVEL or STRUCTURAL — the orchestrator uses this to decide on a fix-mode re-run.]
```
