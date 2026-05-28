$ErrorActionPreference = "Stop"

function Detect-Platform {
    if (Get-Command claude -ErrorAction SilentlyContinue) { return "claude-code" }
    if (Get-Command codex -ErrorAction SilentlyContinue) { return "codex" }
    if (Test-Path ".cursor") { return "cursor" }
    if (Get-Command opencode -ErrorAction SilentlyContinue) { return "opencode" }
    return ""
}

$Platform = ""
if ($args.Length -ge 2 -and $args[0] -eq "--platform") {
    $Platform = $args[1]
}

if ([string]::IsNullOrEmpty($Platform)) {
    $Platform = Detect-Platform
}

if ([string]::IsNullOrEmpty($Platform)) {
    Write-Host "Could not detect platform. Please specify:" -ForegroundColor Red
    Write-Host "  .\install.ps1 --platform claude-code"
    Write-Host "  .\install.ps1 --platform codex"
    Write-Host "  .\install.ps1 --platform cursor"
    Write-Host "  .\install.ps1 --platform opencode"
    exit 1
}

# Clone repo to temp dir if running via iwr | iex (no script file path)
$ONEWORD_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrEmpty($ONEWORD_ROOT) -or -not (Test-Path "$ONEWORD_ROOT\skills")) {
    $TempDir = Join-Path $env:TEMP "oneword-install"
    if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir }
    git clone https://github.com/vswk001/oneword.git $TempDir
    $ONEWORD_ROOT = $TempDir
}

Write-Host "Installing OneWord for $Platform..." -ForegroundColor Green

switch ($Platform) {
    "claude-code" {
        $Target = Join-Path $env:USERPROFILE ".claude\skills"
        New-Item -ItemType Directory -Force -Path $Target | Out-Null
        Get-ChildItem -Path "$ONEWORD_ROOT\skills\oneword-*.md" | ForEach-Object {
            Copy-Item $_.FullName -Destination $Target
            Write-Host "  Installed: $($_.Name)"
        }
        Write-Host ""
        Write-Host "OneWord installed for Claude Code!"
        Write-Host "Usage: /oneword-build <your requirement>"
    }
    "codex" {
        $Target = Join-Path $env:USERPROFILE ".agents\skills"
        New-Item -ItemType Directory -Force -Path $Target | Out-Null
        Get-ChildItem -Path "$ONEWORD_ROOT\skills\oneword-*.md" | ForEach-Object {
            $name = $_.BaseName
            $skillDir = Join-Path $Target $name
            New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
            Copy-Item $_.FullName -Destination (Join-Path $skillDir "skill.md")
            Write-Host "  Installed: $name"
        }
        Write-Host ""
        Write-Host "OneWord installed for Codex!"
        Write-Host "Usage: oneword-build <your requirement>"
    }
    "cursor" {
        $Target = ".cursor\rules"
        New-Item -ItemType Directory -Force -Path $Target | Out-Null
        Get-ChildItem -Path "$ONEWORD_ROOT\skills\oneword-*.md" | ForEach-Object {
            $name = $_.BaseName
            $content = Get-Content $_.FullName -Raw
            $mdc = @"
---
description: OneWord skill: $name
globs:
alwaysApply: false
---

$content
"@
            Set-Content -Path (Join-Path $Target "$name.mdc") -Value $mdc
            Write-Host "  Installed: $name.mdc"
        }
        Write-Host ""
        Write-Host "OneWord installed for Cursor!"
        Write-Host "Usage: In Agent chat, reference @oneword-build <your requirement>"
    }
    "opencode" {
        $Target = "commands"
        New-Item -ItemType Directory -Force -Path $Target | Out-Null
        Get-ChildItem -Path "$ONEWORD_ROOT\skills\oneword-*.md" | ForEach-Object {
            $name = $_.BaseName
            Copy-Item $_.FullName -Destination (Join-Path $Target "$name.md")
            Write-Host "  Installed: $name.md"
        }
        Write-Host ""
        Write-Host "OneWord installed for OpenCode!"
        Write-Host "Usage: /oneword-build <your requirement>"
    }
    default {
        Write-Host "Unknown platform: $Platform" -ForegroundColor Red
        Write-Host "Supported: claude-code, codex, cursor, opencode"
        exit 1
    }
}
