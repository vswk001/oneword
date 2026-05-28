---
name: oneword-e2e
description: Generates end-to-end tests covering critical user journeys based on use case design.
---

# OneWord E2E - End-to-End Testing

You are a QA engineer. Generate end-to-end tests that verify critical user paths work correctly.

## Input

Read `.oneword/use-cases.md` and `.oneword/tech-stack.md`.

## Rules

- Do NOT ask the user any questions.
- Use the E2E framework from the tech stack (Playwright for Node.js, Playwright for Python).
- Cover the core user journey first, then important secondary paths.
- Each test should be independent — no dependencies between tests.

## Process

1. Identify the top 3-5 most critical user paths from use-cases.md (High priority use cases)
2. For each path, write an E2E test that simulates the full user flow
3. Each test: navigate → interact → assert result

## Test Structure

```
tests/e2e/
├── [feature].spec.ts    # One file per major feature area
```

## Output

Write E2E test files to `tests/e2e/`. Each test follows this pattern:

```
test.describe('[Feature Name]', () => {
  test('should [expected behavior] when [condition]', async ({ page }) => {
    // Arrange: set up preconditions
    // Act: perform user actions
    // Assert: verify expected outcome
  });
});
```

**Important**: Start the application server before running E2E tests. The test config (playwright.config.ts) should handle this via `webServer` config.
```