[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.md) [![中文](https://img.shields.io/badge/lang-中文-red.svg)](docs/README_zh.md) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

<div align="center">

# OneWord

**One sentence to a running application.**

Transform a single sentence into a high-quality, runnable application — no technical knowledge required.

[Getting Started](#getting-started) · [How It Works](#how-it-works) · [Supported Platforms](#supported-platforms) · [Roadmap](#roadmap) · [Contributing](#contributing)

</div>

---

## Why OneWord?

You have an idea. You don't know how to code. You shouldn't have to.

OneWord runs a **complete software engineering pipeline** behind the scenes — requirements analysis, use case design, detailed design, test-driven development, automated testing, and quality verification — all triggered by a single sentence.

**No questions asked. No configuration needed. No technical knowledge required.**

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
    │  7. Quality Verification      │
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
- Node.js 18+ (for generated projects)

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

## Supported Platforms

| Platform        | Invocation                     | Install Target      |
| --------------- | ------------------------------ | ------------------- |
| **Claude Code** | `/oneword-build <requirement>` | `~/.claude/skills/` |
| **Codex CLI**   | `oneword-build <requirement>`  | `~/.agents/skills/` |
| **Cursor**      | `@oneword-build <requirement>` | `.cursor/rules/`    |
| **OpenCode**    | `/oneword-build <requirement>` | `commands/`         |

## Tech Stack Selection

OneWord analyzes your requirement and automatically picks the best technology:

| Requirement Type    | Stack                        | Template           |
| ------------------- | ---------------------------- | ------------------ |
| General apps        | React + Node.js + TypeScript | `react-node`       |
| Real-time, SEO, SSR | Next.js 15 + TypeScript      | `nextjs-fullstack` |
| Data analysis, AI   | Vue 3 + Python FastAPI       | `vue-python`       |
| Lightweight tools   | React + Flask                | `react-flask`      |

Every generated project includes:

- TypeScript (or Python) backend with clean architecture
- Modern frontend with Tailwind CSS
- Jest + Playwright test suites
- ESLint / Pylint configuration
- One-command startup: `npm install && npm start`

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
├── oneword-code.md         # TDD coding → src/ + tests/
├── oneword-e2e.md          # E2E tests → tests/e2e/
├── oneword-verify.md       # Quality gate → test-report.md
└── oneword-deliver.md      # Delivery → README.md + startup
```

Each skill is a pure markdown instruction file — no code dependencies, no platform-specific logic. Platform adapters handle format conversion during installation.

## Roadmap

- [x] **v0.1** — Core pipeline with 8 skills, 4 templates, 4 platforms
- [ ] **v0.2** — Auto-fix improvements, more templates (Vue + Node, Svelte)
- [ ] **v0.3** — Plugin system with CLI installer
- [ ] **v1.0** — Plugin marketplace, community templates, documentation site

## Contributing

We welcome contributions of all kinds — new templates, plugins, bug fixes, and documentation.

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-feature`)
3. Commit your changes (`git commit -m 'feat: add my feature'`)
4. Push to the branch (`git push origin feat/my-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## License

OneWord is [MIT licensed](LICENSE).

## Acknowledgements

Built for the AI coding community. Inspired by the idea that everyone deserves to build software, regardless of technical background.

---

<div align="center">

**[Report Bug](https://github.com/vswk001/oneword/issues) · [Request Feature](https://github.com/vswk001/oneword/issues) · [Discussions](https://github.com/vswk001/oneword/discussions)**

</div>
