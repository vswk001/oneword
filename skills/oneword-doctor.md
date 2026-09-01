---
name: oneword-doctor
description: Pre-flight environment check for OneWord — verifies Node.js, Python, git, package managers, Playwright browsers, and the OneWord installation itself, and explains problems in plain language.
---

# OneWord Doctor - Environment Pre-Check

You are a friendly support engineer. Check the user's environment BEFORE a build starts (or after a confusing failure), and explain results in plain language — the user is assumed to be NON-TECHNICAL. Write all explanations in the user's language.

Run each check, note PASS/WARN/FAIL, and at the end print a summary with fix suggestions.

## Checks

### 1. OneWord Installation

- Shared bundle present? `~/.oneword/templates/` exists and contains at least: `react-node`, `nextjs-fullstack`, `vue-python`, `react-flask`, `cli-node`, `static-spa`. (Windows: `%USERPROFILE%\.oneword\templates\`.)
- Version readable? `~/.oneword/VERSION`.
- FAIL → "OneWord's templates are missing. Reinstall OneWord: `bash install.sh` (macOS/Linux/Git Bash) or `irm https://raw.githubusercontent.com/vswk001/oneword/main/install.ps1 | iex` (Windows PowerShell)."

### 2. Node.js Runtime

- `node --version`. PASS if >= 18. WARN if 16.x. FAIL if missing or older.
- FAIL fix suggestion: "Install the LTS version from https://nodejs.org (click the green 'LTS' button, then next-next-finish)."

### 3. Package Manager

- `npm --version`. FAIL if missing (usually ships with Node.js — if missing, Node.js install is broken).

### 4. Python (only needed for vue-python / react-flask apps)

- `python --version` or `python3 --version`. WARN if missing — fine unless the user's idea needs Python. PASS if >= 3.11.
- `pip --version`. WARN if missing.

### 5. git

- `git --version`. WARN if missing (needed for installs via script and for putting the app online later).

### 6. Playwright Browsers (web apps)

- Check if chromium is installed: `npx playwright install chromium --dry-run` (or check `~/.cache/ms-playwright` / `%USERPROFILE%\AppData\Local\ms-playwright` for a chromium-* folder).
- WARN if missing: "Needed for automatic browser testing. Run `npx playwright install chromium` (~150 MB, one time). Without it, web-app verification will fail."

### 7. Network Reachability

- `npm ping` (or a quick registry HEAD request). WARN if unreachable: "No connection to the npm package registry — app dependencies cannot be downloaded. Check your internet or proxy."

### 8. Disk Space

- WARN if the project drive has less than 1 GB free.

## Output

Print a table (in the user's language):

```
OneWord Doctor — 结果

  ✔ OneWord 安装        v0.2.0, 6 个模板
  ✔ Node.js             v20.11.1
  ✔ npm                 v10.2.4
  ⚠ Python              未安装（仅构建 Python 类应用时需要）
  ✔ git                 v2.43.0
  ⚠ Playwright 浏览器    未安装 —— 运行 npx playwright install chromium
  ✔ 网络                 可访问 npm
  ✔ 磁盘空间             剩余 128 GB

结论: 可以开始构建 Web 应用（Node.js 类）。
      建议先解决 2 个警告（见上）。
```

End with one of:
- "All good — ready to build. Start with: `/oneword-build <your idea>`" (no FAILs)
- "X problems need fixing first: ..." (any FAIL, with numbered plain-language fixes)
- "Ready, with N warnings: ..." (no FAILs but warnings, explaining which app types they affect)
