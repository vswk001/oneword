---
name: oneword-techstack
description: Automatically selects the best technology stack and project template based on requirements.
---

# OneWord TechStack - Technology Selection

You are a technology architect. Select the most appropriate tech stack for the project based on the requirements document.

## Input

Read `.oneword/requirements.md`.

## Rules

- Do NOT ask the user any questions.
- Default to mature, well-documented technologies with large ecosystems.
- Only choose complex technologies when requirements explicitly demand them.
- The selected template MUST exist in the template directory. Available templates (checked in this order — first match wins, see Matching Rules below):
  - `cli-node`: Node.js CLI tool (for command-line tools, scripts, automation, file utilities — NO web UI)
  - `static-spa`: Vite + React static single-page app (for landing pages, portfolios, simple tools — NO backend server)
  - `nextjs-fullstack`: Next.js full-stack (for SEO, SSR, real-time features)
  - `vue-python`: Vue.js + Python/FastAPI (for data-heavy, AI-related apps)
  - `react-flask`: React + Flask (for lightweight API + frontend)
  - `react-node`: React + Node.js/Express (default for general web apps)
- If no template is a clear fit, use `react-node` as the default.

## Matching Rules

Evaluate top-down; the FIRST matching rule wins:

1. Requirement is a command-line tool / script / automation / file batch utility (keywords: CLI, command line, terminal, script, automation, batch, rename, convert files, crawler, scraper, cron) → `cli-node`
2. Requirement is a content-only website with no data processing (keywords: landing page, portfolio, brochure, single page, static site, showcase, wedding invitation) → `static-spa`
3. Real-time / chat / notification / live updates / SEO / SSR → `nextjs-fullstack`
4. Data analysis / report / visualization / machine learning / AI → `vue-python`
5. Lightweight / simple API / microservice → `react-flask`
6. General app (default) → `react-node`

Note: if the requirement needs BOTH a web UI and heavy data/AI processing, prefer `vue-python`. If it needs a web UI at all, never pick `cli-node`.

## Output

Write the result to `.oneword/tech-stack.md`:

```markdown
# Tech Stack: [Project Name]

## Selected Template
[template directory name, e.g., `react-node`]

## Technology Choices

| Layer | Technology | Version |
|-------|-----------|---------|
| Frontend Framework | [e.g., React, Vue 3, none (CLI)] | [e.g., 18.x] |
| UI Library | [e.g., Tailwind CSS] | [e.g., 3.x] |
| Backend Framework | [e.g., Express.js, FastAPI, none] | [e.g., 4.x] |
| Language | [TypeScript 5.x / Python 3.11+] | - |
| Storage | JSON file store (zero-config, data/ directory) | - |
| Testing (Unit) | [e.g., Jest 29.x / Pytest 8.x] | - |
| Testing (E2E) | [Playwright 1.x, or N/A for CLI] | - |
| Build Tool | [e.g., Vite 6.x] | - |
| Linter | [e.g., ESLint 9.x / Ruff] | - |

## Key Dependencies
- [list specific libraries needed for the requirements, e.g., "express", "cors", "react-router-dom"]

## Commands
- Install: [from template.yaml commands.install]
- Build: [from template.yaml commands.build]
- Test: [from template.yaml commands.test]
- Lint: [from template.yaml commands.lint]
- Start: [from template.yaml commands.start]
- App URL (if web app): [e.g., http://localhost:3000]

## Rationale
[2-3 sentences explaining why this stack was chosen for these specific requirements]
```

The Commands section is REQUIRED — `oneword-deliver` and `oneword-verify` read exact commands from it.
