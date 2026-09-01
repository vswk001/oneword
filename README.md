[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.md) [![中文](https://img.shields.io/badge/lang-中文-red.svg)](docs/README_zh.md) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md) [![CI](https://github.com/vswk001/oneword/actions/workflows/ci.yml/badge.svg)](https://github.com/vswk001/oneword/actions/workflows/ci.yml)

<div align="center">

# OneWord

**One sentence to a running application.**

Transform a single sentence into a high-quality, runnable application — no technical knowledge required.

[Getting Started](#getting-started) · [How It Works](#how-it-works) · [Supported Platforms](#supported-platforms) · [Roadmap](#roadmap) · [Contributing](#contributing)

</div>

---

## Why OneWord?

You have an idea. You don't know how to code. You shouldn't have to.

OneWord runs a **complete software engineering pipeline** behind the scenes — requirements analysis, use case design, detailed design, test-driven development, automated testing, quality and security verification — all triggered by a single sentence.

**No questions asked. No configuration needed. No technical knowledge required.**

And it doesn't stop at the first version: **iterate** with follow-up sentences, **resume** an interrupted build, and **doctor** your environment before you start.

## How It Works

```
You: "I want a bookkeeping app"
                    │
    ┌───────────────▼───────────────┐
    │      OneWord Pipeline         │
    │                               │
    │  1. Requirements Analysis     │
    │  2. Tech Stack Selection      │
    │  3. Use Case Design           │
    │  4. Detailed Design           │
    │  5. TDD Coding                │
    │  6. E2E Testing               │
    │  7. Quality & Security Gate   │
    │  8. Delivery                  │
    │                               │
    └───────────────┬───────────────┘
                    │
                    ▼
        A running application
        with tests, clean code,
        and a README
```

## Getting Started

### Prerequisites

- An AI coding tool installed (Claude Code, Codex CLI, Cursor, or OpenCode)
- Node.js 18+ (for generated projects); Python 3.11+ for data/AI apps
- git (required for one-line installs)

### Install

**macOS / Linux:**

```bash
curl -fsSL https://raw.githubusercontent.com/vswk001/oneword/main/install.sh | bash
```

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/vswk001/oneword/main/install.ps1 | iex
```

**Manual platform selection:**

```bash
bash install.sh --platform claude-code
# or: codex, cursor, opencode
```

The installer puts the skills where your AI tool looks for them, and installs the shared bundle (project templates + pipeline config) to `~/.oneword/` (`%USERPROFILE%\.oneword\` on Windows).

**Uninstall / check version:**

```bash
bash uninstall.sh            # removes skills + shared bundle (all platforms)
cat ~/.oneword/VERSION       # installed version
```

### Usage

```bash
# Claude Code
/oneword-build I want a bookkeeping app

# Codex CLI
oneword-build I want a bookkeeping app

# Cursor
@oneword-build I want a bookkeeping app

# OpenCode
/oneword-build I want a bookkeeping app
```

That's it. Your app will be generated in the current directory with everything ready to run.

**Beyond the first build:**

```bash
/oneword-iterate add CSV export to the records page   # change an existing app
/oneword-resume                                        # resume an interrupted build (or show status)
/oneword-doctor                                        # check your environment in plain language
```

Write your requirement in any language — the generated README and final summary are written in YOUR language.

## Supported Platforms

| Platform        | Invocation                      | Install Target      |
| --------------- | ------------------------------- | ------------------- |
| **Claude Code** | `/oneword-build <requirement>`  | `~/.claude/skills/` |
| **Codex CLI**   | `oneword-build <requirement>`   | `~/.agents/skills/` |
| **Cursor**      | `@oneword-build <requirement>`  | `.cursor/rules/`    |
| **OpenCode**    | `/oneword-build <requirement>`  | `commands/`         |

All platforms additionally get the shared bundle in `~/.oneword/` (templates + config).

## Tech Stack Selection

OneWord analyzes your requirement and automatically picks the best technology:

| Requirement Type      | Stack                             | Template           |
| --------------------- | --------------------------------- | ------------------ |
| CLI tools & scripts   | Node.js + TypeScript + Commander  | `cli-node`         |
| Landing pages, portfolios | React + Vite (no backend)      | `static-spa`       |
| General apps          | React + Node.js + TypeScript      | `react-node`       |
| Real-time, SEO, SSR   | Next.js 15 + TypeScript           | `nextjs-fullstack` |
| Data analysis, AI     | Vue 3 + Python FastAPI            | `vue-python`       |
| Lightweight tools     | React + Flask                     | `react-flask`      |

Every generated project includes:

- TypeScript (or Python) backend with clean architecture where a backend applies
- Modern frontend with Tailwind CSS where a UI applies
- Unit + E2E test suites (Jest/Vitest/Pytest + Playwright)
- Linting (ESLint / Ruff), security audit, and coverage thresholds (80%)
- `.gitignore`, `.env.example`, and a plain-language README in your language
- One-command startup: `npm install && npm start`

## Quality & Security Gate

Before delivery, every build must pass (`oneword-verify`):

- 100% of tests passing, coverage ≥ 80% where measurable
- Lint and production build pass
- App starts and responds within 10 seconds
- `npm audit` with no HIGH/CRITICAL findings, no hardcoded secrets, `.env` gitignored, servers bound to localhost by default

Failures are auto-fixed in a bounded retry loop; anything structural triggers a scoped fix-mode re-run instead of a rewrite.

## Plugin System

OneWord supports a plugin architecture for extending the pipeline:

```yaml
# Example plugin
name: oneword-plugin-i18n
type: enhancer          # Adds capability after a stage
stage: after-code       # Insertion point in pipeline
```

**Plugin types:** `enhancer` (add capability), `replacer` (override a built-in skill), `template` (new project template)

Plugin marketplace and discovery coming in v2.

## Architecture

OneWord is built as a **skill chain** — a sequence of independent, composable skills orchestrated by a master skill:

```
skills/
├── oneword-build.md        # Master orchestrator
├── oneword-analyze.md      # Requirements → requirements.md
├── oneword-techstack.md    # Tech selection → tech-stack.md
├── oneword-usecases.md     # Use case design → use-cases.md
├── oneword-design.md       # Detailed design → design.md
├── oneword-code.md         # TDD coding → src/ + tests/ (+ fix mode)
├── oneword-e2e.md          # E2E tests → tests/e2e/
├── oneword-verify.md       # Quality & security gate → test-report.md
├── oneword-deliver.md      # Delivery → README.md + startup
├── oneword-iterate.md      # Incremental changes to a finished app
├── oneword-resume.md       # Resume interrupted build / show status
└── oneword-doctor.md       # Environment pre-flight check
```

Each skill is a pure markdown instruction file — no code dependencies, no platform-specific logic. The orchestrator locates and reads each skill file sequentially and follows it, so the chain runs identically on every supported platform. Platform adapters handle format conversion during installation.

## Roadmap

- [x] **v0.1** — Core pipeline with 8 skills, 4 templates, 4 platforms
- [x] **v0.2** — Iterate/resume/doctor skills, CLI + static templates, security gate, install/uninstall/versioning, CI
- [ ] **v0.3** — Plugin system with CLI installer, more templates (Svelte, Vue + Node, mobile)
- [ ] **v1.0** — Plugin marketplace, community templates, documentation site

## Contributing

We welcome contributions of all kinds — new templates, plugins, bug fixes, and documentation.

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-feature`)
3. Commit your changes (`git commit -m 'feat: add my feature'`)
4. Push to the branch (`git push origin feat/my-feature`)
5. Open a Pull Request

CI runs markdown fence checks, YAML validation, and build/test smoke tests for every template — your PR must pass them. See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## License

OneWord is [MIT licensed](LICENSE).

## Acknowledgements

Built for the AI coding community. Inspired by the idea that everyone deserves to build software, regardless of technical background.

---

<div align="center">

**[Report Bug](https://github.com/vswk001/oneword/issues) · [Request Feature](https://github.com/vswk001/oneword/issues) · [Discussions](https://github.com/vswk001/oneword/discussions)**

</div>
