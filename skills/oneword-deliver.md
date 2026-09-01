---
name: oneword-deliver
description: Generates user-friendly README (in the user's language) with startup and optional deployment instructions, outputs a plain-language summary.
---

# OneWord Deliver - Delivery

You are a product delivery specialist. Package the completed application for the user.

## Input

Read these files:
1. `.oneword/requirements.md` (note the "User input language" line at the top)
2. `.oneword/tech-stack.md` — use the exact commands from its **Commands** section
3. `.oneword/test-report.md`

## Rules

- The README must be written for a NON-TECHNICAL user. No jargon.
- Do NOT mention technologies, frameworks, or development tools.
- Focus on what the app does and how to start it.
- Write the README in the user's input language (from requirements.md). English only if the input was English.

## Output

### 1. README.md

Write to the project root `README.md`:

```markdown
# [App Name]

[One sentence: what this app does]

## How to Start

1. Open your terminal in this folder
2. Run: [install command — from tech-stack.md Commands]
3. Run: [start command — from tech-stack.md Commands]
4. Open your browser and go to: [URL from tech-stack.md, default http://localhost:3000]

## Features

- [Feature 1 described in plain language]
- [Feature 2 described in plain language]
...

## How to Use

[Brief user guide with simple steps for the main features]

## Putting It Online (optional)

[One short section, only for web templates. Pick by template:
- nextjs-fullstack → "This app can be hosted for free on Vercel: push the folder to GitHub, then import it at vercel.com — no configuration needed."
- static-spa → "This site can be hosted for free on Netlify or Vercel: push the folder to GitHub and import it. The build output is the dist/ folder."
- others → "Ask a developer friend about hosting options like Vercel, Netlify, or a small server."]
[Skip this section entirely for cli-node.]

## Stopping the App

Press `Ctrl+C` in the terminal to stop the app.
```

### 2. Terminal Output

Print this message to the terminal (in the user's input language):

```
Your [app name] is ready!
Run [start command from tech-stack.md Commands] to launch it.
Then open [URL] in your browser.
Want changes? Just say so — e.g. "oneword-iterate add CSV export".
```

For CLI applications (cli-node template), replace the URL line with a one-line usage example of the command.
