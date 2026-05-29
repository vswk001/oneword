[![English](https://img.shields.io/badge/lang-English-blue.svg)](../README.md) [![中文](https://img.shields.io/badge/lang-中文-red.svg)](docs/README_zh.md) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](../LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](../CONTRIBUTING.md)

<div align="center">

# OneWord

**一句话，一个能跑的应用。**

只需一句话描述你的需求，OneWord 自动生成一个高质量、可直接运行的应用——无需任何技术背景。

[快速开始](#快速开始) · [工作原理](#工作原理) · [支持平台](#支持平台) · [路线图](#路线图) · [参与贡献](#参与贡献)

</div>

---

## 为什么选择 OneWord？

你有一个想法，但你不会写代码。这不应该是阻碍。

OneWord 在幕后运行一整套**专业软件工程流水线**——需求分析、用例设计、详细设计、测试驱动开发、自动化测试、质量验证——全部由一句话触发。

**不提问。不配置。不需要技术知识。**

## 工作原理

```
你："我想做一个记账应用"
                │
    ┌───────────▼───────────┐
    │    OneWord 流水线      │
    │                       │
    │  1. 需求分析           │
    │  2. 技术选型           │
    │  3. 用例设计           │
    │  4. 详细设计           │
    │  5. TDD 编码           │
    │  6. E2E 测试           │
    │  7. 质量验证           │
    │  8. 应用交付           │
    │                       │
    └───────────┬───────────┘
                │
                ▼
    一个可以直接运行的应用
    包含测试、整洁代码和使用说明
```

## 快速开始

### 前置条件

- 已安装 AI 编程工具（Claude Code、Codex CLI、Cursor 或 OpenCode）
- Node.js 18+（用于生成的项目）

### 安装

**macOS / Linux：**

```bash
curl -fsSL https://raw.githubusercontent.com/vswk001/oneword/main/install.sh | bash
```

**Windows (PowerShell)：**

```powershell
irm https://raw.githubusercontent.com/vswk001/oneword/main/install.ps1 | iex
```

**手动指定平台：**

```bash
bash install.sh --platform claude-code
# 或：codex, cursor, opencode
```

### 使用

```bash
# Claude Code
/oneword-build 我想做一个记账应用

# Codex CLI
oneword-build 我想做一个记账应用

# Cursor
@oneword-build 我想做一个记账应用

# OpenCode
/oneword-build 我想做一个记账应用
```

就这么简单。你的应用会在当前目录下生成，开箱即用。

## 支持平台

| 平台 | 调用方式 | 安装位置 |
|------|---------|---------|
| **Claude Code** | `/oneword-build <需求>` | `~/.claude/skills/` |
| **Codex CLI** | `oneword-build <需求>` | `~/.agents/skills/` |
| **Cursor** | `@oneword-build <需求>` | `.cursor/rules/` |
| **OpenCode** | `/oneword-build <需求>` | `commands/` |

## 技术栈自动选择

OneWord 会分析你的需求，自动选择最合适的技术方案：

| 需求类型 | 技术栈 | 模板 |
|---------|--------|------|
| 通用应用 | React + Node.js + TypeScript | `react-node` |
| 实时通信、SEO、SSR | Next.js 15 + TypeScript | `nextjs-fullstack` |
| 数据分析、AI 相关 | Vue 3 + Python FastAPI | `vue-python` |
| 轻量级工具 | React + Flask | `react-flask` |

每个生成的项目都包含：

- TypeScript（或 Python）后端，遵循整洁架构
- 现代化前端，使用 Tailwind CSS
- Jest + Playwright 测试套件
- ESLint / Pylint 代码规范配置
- 一键启动：`npm install && npm start`

## 插件系统

OneWord 支持插件架构来扩展流水线能力：

```yaml
# 插件示例
name: oneword-plugin-i18n
type: enhancer          # 在某个阶段后增加能力
stage: after-code       # 插入点
```

**插件类型：** `enhancer`（增强能力）、`replacer`（替换内置技能）、`template`（新项目模板）

插件市场和社区发现功能将在 v2 版本推出。

## 架构

OneWord 基于**技能链**架构——一组独立、可组合的技能，由主技能编排调度：

```
skills/
├── oneword-build.md        # 主编排器
├── oneword-analyze.md      # 需求分析 → requirements.md
├── oneword-techstack.md    # 技术选型 → tech-stack.md
├── oneword-usecases.md     # 用例设计 → use-cases.md
├── oneword-design.md       # 详细设计 → design.md
├── oneword-code.md         # TDD 编码 → src/ + tests/
├── oneword-e2e.md          # E2E 测试 → tests/e2e/
├── oneword-verify.md       # 质量门禁 → test-report.md
└── oneword-deliver.md      # 应用交付 → README.md + 启动命令
```

每个技能都是纯 Markdown 指令文件——没有代码依赖，没有平台特定逻辑。平台适配器在安装时处理格式转换。

## 路线图

- [x] **v0.1** — 核心流水线：8 个技能、4 个模板、4 个平台
- [ ] **v0.2** — 自动修复增强、更多模板（Vue + Node、Svelte）
- [ ] **v0.3** — 插件系统，支持 CLI 安装
- [ ] **v1.0** — 插件市场、社区模板、文档站

## 参与贡献

我们欢迎各种形式的贡献——新模板、插件、Bug 修复、文档完善。

1. Fork 本仓库
2. 创建功能分支（`git checkout -b feat/my-feature`）
3. 提交你的修改（`git commit -m 'feat: add my feature'`）
4. 推送到分支（`git push origin feat/my-feature`）
5. 发起 Pull Request

详细指南请参考 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 开源许可

OneWord 采用 [MIT 许可证](LICENSE) 开源。

## 致谢

为 AI 编程社区而建。每个人都值得拥有创造软件的能力，无论技术背景如何。

---

<div align="center">

**[报告问题](https://github.com/vswk001/oneword/issues) · [功能建议](https://github.com/vswk001/oneword/issues) · [社区讨论](https://github.com/vswk001/oneword/discussions)**

</div>
