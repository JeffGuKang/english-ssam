# English Ssam - AI Agent Installation Guide

This file helps AI coding assistants understand how to install English Ssam.

## Slash Command

**`/english-ssam`** - Toggle English Ssam on/off

When user types `/english-ssam`:
1. If English Ssam is currently **OFF** → Turn **ON** (activate tutor mode)
2. If English Ssam is currently **ON** → Turn **OFF** (disable tutor mode)

This works across all AI tools (OpenCode, Cursor, Claude, Copilot, etc.)

## Installation Commands

When user requests installation of "English Ssam" or "영어쌤" or "잉글리쉬쌤":

### Detect User's AI Tool

First, check which AI tool the user is using by looking at:
- Current environment (Cursor, VS Code with Copilot, etc.)
- Config files in the project (`.cursorrules`, `CLAUDE.md`, etc.)
- Ask user if unclear

### Installation Matrix

| User Request | Command |
|--------------|---------|
| "install english-ssam globally" | Use OpenCode/Aider/Continue global install |
| "install english-ssam locally" | Use tool-specific local install |
| "영어쌤 설치해줘" / "잉글리쉬쌤 설치해줘" | Detect tool, install appropriately |
| "install english-ssam for cursor" | `curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh \| bash -s -- --tool=cursor --local` |
| "install english-ssam for claude" | `curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh \| bash -s -- --tool=claude-code --local` |

### Tool-Specific Commands

```bash
# OpenCode (global)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global

# Cursor (local - creates .cursorrules)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local

# Claude Code CLI (local - creates CLAUDE.md)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=claude-code --local

# GitHub Copilot (local - creates .github/copilot-instructions.md)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=copilot --local

# Windsurf (local - creates .windsurfrules)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=windsurf --local

# Aider (global)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=aider --global

# Continue.dev (global)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=continue --global

# Zed (local - creates .zed/prompt.md)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=zed --local
```

### Toggle (Enable/Disable)

```bash
# Disable temporarily (keeps backup)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --disable

# Enable (restore from backup)
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --enable

# Check status
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --status
```

### Uninstall

Add `--uninstall` flag to any install command:
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --uninstall
```

## Natural Language Triggers

Respond to these phrases by running the appropriate install command:

**English:**
- "install english-ssam" → install
- "setup english-ssam" → install
- "add english-ssam" → install
- "install english tutor" → install
- "enable english-ssam" / "turn on english-ssam" → enable
- "disable english-ssam" / "turn off english-ssam" → disable
- "english-ssam status" / "is english-ssam installed?" → status

**Korean (한국어):**
- "영어쌤 설치해줘" → install
- "잉글리쉬쌤 설치해줘" → install
- "영어쌤 설치" → install
- "영어 선생님 설치" → install
- "영어쌤 로컬에 설치해줘" → local install
- "영어쌤 전역으로 설치해줘" → global install
- "영어쌤 꺼줘" / "영어쌤 끄기" / "영어쌤 비활성화" → disable
- "영어쌤 켜줘" / "영어쌤 켜기" / "영어쌤 활성화" → enable
- "영어쌤 상태" / "영어쌤 상태 확인" → status

**Japanese (日本語):**
- "English Ssamをインストールして" → install
- "英語先生をセットアップして" → install
- "English Ssamを無効にして" / "英語先生をオフにして" → disable
- "English Ssamを有効にして" / "英語先生をオンにして" → enable

**Chinese (中文):**
- "安装English Ssam" / "安装英语老师" → install
- "禁用English Ssam" / "关闭英语老师" → disable
- "启用English Ssam" / "开启英语老师" → enable
