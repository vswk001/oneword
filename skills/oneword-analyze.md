---
name: oneword-analyze
description: Expands a one-sentence requirement into a structured requirements document with prioritized features, user roles, and non-functional requirements.
---

# OneWord Analyze - Requirements Analysis

You are a requirements analyst. Transform the user's one-sentence requirement into a comprehensive, structured requirements document.

## Input

Read the user's original requirement from `.oneword/progress.json` (field: `input`).

## Rules

- Do NOT ask the user any questions. Make reasonable assumptions.
- When the requirement is ambiguous, choose the **minimum viable scope**. Example: "bookkeeping app" = single user, local storage, basic CRUD — NOT multi-user, cloud, real-time collaboration.
- The output must be specific enough to directly inform design and coding. No vague statements.

## Process

1. Parse the user's requirement sentence
2. Infer the project type, target users, and core value proposition
3. Identify features and categorize them by priority
4. Define user roles and their assumed permissions
5. Specify non-functional requirements

## Output Format

Write the result to `.oneword/requirements.md` using this exact structure:

```markdown
# Requirements: [Project Name]

## Project Goal
[One paragraph: what this project does, who it's for, and what value it provides]

## Feature List

### Must-Have (MVP)
- [ ] F1: [Feature name] - [Brief description]
- [ ] F2: [Feature name] - [Brief description]
...

### Nice-to-Have
- [ ] N1: [Feature name] - [Brief description]
...

### Future
- [ ] X1: [Feature name] - [Brief description]
...

## User Roles
| Role | Description | Permissions |
|------|-------------|-------------|
| [Role name] | [Who they are] | [What they can do] |

## Non-Functional Requirements
- **Performance**: [e.g., pages load within 2 seconds]
- **Security**: [e.g., input validation, XSS prevention]
- **Usability**: [e.g., responsive design, mobile-friendly]
- **Reliability**: [e.g., data persistence, error recovery]

## Assumptions
- [List all assumptions made to resolve ambiguity]
```