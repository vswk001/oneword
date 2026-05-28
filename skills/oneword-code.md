---
name: oneword-code
description: Implements the application using TDD practice — test first, then implement, then refactor, per module. Reads design doc and produces source code + unit/integration tests.
---

# OneWord Code - Implementation with TDD

You are a senior developer. Implement the application following TDD practice, working through each module systematically.

## Input

Read these files in order:
1. `.oneword/tech-stack.md` — to know which template to use
2. `.oneword/design.md` — to know what to build
3. `.oneword/use-cases.md` — to derive test cases from acceptance criteria

## Step 0: Initialize Project from Template

Copy the selected template directory into the project root:
```bash
cp -r templates/<selected-template>/* .
```

Then install dependencies:
```bash
npm install  # or pip install -r requirements.txt for Python templates
```

## TDD Implementation Cycle

Work through the modules in the "Implementation Order" from design.md. For each module:

### 1. Write Failing Test

Write a unit test (or integration test for API routes) based on the use case acceptance criteria.

Test file structure mirrors `src/` structure:
```
src/models/item.ts       → tests/unit/models/item.test.ts
src/routes/items.ts      → tests/integration/routes/items.test.ts
```

Test naming convention: `should <expected behavior> when <condition>`

### 2. Write Minimal Implementation

Write the minimum code needed to make the test pass. Do NOT over-engineer.

### 3. Refactor

Once the test passes:
- Ensure meaningful names (no abbreviations, no single-letter variables)
- Extract small functions (max 20 lines per function)
- Remove any magic numbers — use named constants
- Apply design patterns from design.md where specified
- No dead code, no commented-out code, no unnecessary abstractions

### 4. Repeat

Move to the next test case for this module. When all tests pass, move to the next module.

## Coding Standards

- **Clean Code**: Meaningful names, small functions, no side effects in pure functions
- **Type Safety**: Use TypeScript types/interfaces (or Python type hints). No `any`.
- **Error Handling**: Validate at system boundaries (user input, external APIs). Trust internal code.
- **No Comments**: Code should be self-documenting. Only add comments for non-obvious WHY.
- **No YAGNI**: Don't add features not in the design. Don't over-abstract.

## Output

- Source code in `src/`
- Unit tests in `tests/unit/`
- Integration tests in `tests/integration/`
- All tests should pass after implementation