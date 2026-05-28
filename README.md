# OneWord

> One sentence to a running application.

OneWord is an open-source AI-powered workflow that transforms a single sentence requirement into a high-quality, runnable web application. No technical knowledge required.

## How It Works

1. You describe what you want in one sentence
2. OneWord runs a complete software engineering pipeline automatically
3. You get a working application you can start immediately

Behind the scenes, OneWord follows professional software engineering practices:
requirements analysis, use case design, detailed design, test-driven development,
automated testing, and quality verification.

## Install

```bash
# Clone the repository
git clone https://github.com/oneword/oneword.git
cd oneword

# Install for your platform
bash install.sh --platform claude-code
# or: codex, cursor, opencode
```

## Usage

Once installed, use OneWord in your AI coding tool:

| Platform | How to Use |
|----------|-----------|
| Claude Code | `/oneword-build I want a bookkeeping app` |
| Codex CLI | `oneword-build I want a bookkeeping app` |
| Cursor | `@oneword-build I want a bookkeeping app` |
| OpenCode | `/oneword-build I want a bookkeeping app` |

That's it. No questions asked, no configuration needed.

## Supported Project Types

OneWord automatically selects the best technology for your needs:
- **General web apps** → React + Node.js
- **Real-time / SEO apps** → Next.js
- **Data / AI apps** → Vue + Python
- **Lightweight apps** → React + Flask

## Plugin System

OneWord supports plugins to extend its capabilities. (Plugin marketplace coming in v2.)

## Contributing

Contributions are welcome! Please read our contributing guidelines.

## License

MIT
