$ErrorActionPreference = "Stop"

# OneWord uninstaller for Windows.
# Usage: .\uninstall.ps1 [--platform <claude-code|codex|cursor|opencode>]
#        Without --platform, removes OneWord from ALL detected platforms.

$OneWordHome = Join-Path $env:USERPROFILE ".oneword"

function Remove-Skills {
    param([string]$Target, [string]$Pattern, [string]$Label)
    if (-not (Test-Path $Target)) {
        Write-Host "  ${Label}: nothing to remove ($Target not found)"
        return
    }
    $items = Get-ChildItem -Path $Target -Filter $Pattern -ErrorAction SilentlyContinue
    if ($items) {
        $items | ForEach-Object { Remove-Item -Recurse -Force $_.FullName }
        Write-Host "  ${Label}: removed skills from $Target"
    }
    else {
        Write-Host "  ${Label}: nothing to remove in $Target"
    }
}

$Platform = ""
if ($args.Length -ge 2 -and $args[0] -eq "--platform") {
    $Platform = $args[1]
}

Write-Host "Uninstalling OneWord..." -ForegroundColor Green

if ([string]::IsNullOrEmpty($Platform)) { $Platform = "all" }

switch ($Platform) {
    "claude-code" { Remove-Skills -Target (Join-Path $env:USERPROFILE ".claude\skills") -Pattern "oneword-*" -Label "Claude Code" }
    "codex"       { Remove-Skills -Target (Join-Path $env:USERPROFILE ".agents\skills") -Pattern "oneword-*" -Label "Codex CLI" }
    "cursor"      { Remove-Skills -Target ".cursor\rules" -Pattern "oneword-*.mdc" -Label "Cursor" }
    "opencode"    { Remove-Skills -Target "commands" -Pattern "oneword-*.md" -Label "OpenCode" }
    "all" {
        Remove-Skills -Target (Join-Path $env:USERPROFILE ".claude\skills") -Pattern "oneword-*" -Label "Claude Code"
        Remove-Skills -Target (Join-Path $env:USERPROFILE ".agents\skills") -Pattern "oneword-*" -Label "Codex CLI"
        Remove-Skills -Target ".cursor\rules" -Pattern "oneword-*.mdc" -Label "Cursor"
        Remove-Skills -Target "commands" -Pattern "oneword-*.md" -Label "OpenCode"
    }
    default {
        Write-Host "Unknown platform: $Platform" -ForegroundColor Red
        Write-Host "Supported: claude-code, codex, cursor, opencode, or omit for all"
        exit 1
    }
}

if (Test-Path $OneWordHome) {
    Remove-Item -Recurse -Force $OneWordHome
    Write-Host "  Removed shared bundle: $OneWordHome"
}
else {
    Write-Host "  Shared bundle: nothing to remove ($OneWordHome not found)"
}

if (Test-Path ".oneword") {
    Remove-Item -Recurse -Force ".oneword"
    Write-Host "  Removed local .oneword/ artifacts in $(Get-Location)"
}

Write-Host "OneWord uninstalled." -ForegroundColor Green
