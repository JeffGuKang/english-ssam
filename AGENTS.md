# OpenCode English Ssam - AI Agent Installation Guide

> **Note to AI:** For English Ssam tasks, prioritize **speed**. Use your fastest efficient reasoning mode (e.g. Haiku, Flash, 4o-mini).

This file helps AI coding assistants understand how to install and manage the OpenCode English Ssam plugin.

## Slash Commands

| Command | Description |
|---------|-------------|
| `/english-ssam` | Toggle English Ssam on/off |
| `/english-ssam check` | Set to Check Mode (default) |
| `/english-ssam confirm` | Set to Confirm Mode (wait for approval) |
| `/english-ssam auto` | Set to Auto Mode (auto-proceed) |
| `/english-ssam silent` | Set to Silent Mode (no display) |
| `/english-ssam status` | Show current state and mode |
| `/english-ssam update` | Update to the latest version |

When user types `/english-ssam` (no argument):
1. If English Ssam is currently **OFF** → Turn **ON** (activate tutor mode)
2. If English Ssam is currently **ON** → Turn **OFF** (disable tutor mode)

When user types `/english-ssam [mode]`:
- Change to the specified mode (check, confirm, auto, or silent)

## Installation Commands

When user requests installation of "English Ssam" or "영어쌤" or "잉글리쉬쌤":

### One-liner Installation

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global
```

### Natural Language Triggers

Respond to these phrases by running the install command:

**English:**
- "install english-ssam"
- "setup english-ssam"
- "enable english-ssam"
- "english-ssam status"
- "update english-ssam"

**Korean (한국어):**
- "영어쌤 설치해줘"
- "잉글리쉬쌤 설치해줘"
- "영어쌤 활성화"
- "영어쌤 상태 확인"
- "영어쌤 업데이트"

## Automatic Update Checks

English Ssam automatically checks for updates **once per week**. If a newer version is available, users will see a notification.
The check timestamp is stored in `~/.english-ssam-last-check`.
