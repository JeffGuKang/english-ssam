---
name: english-ssam
description: English Ssam (쌤) - Your friendly English tutor for AI coding assistants
version: 1.4.0
author: Jeff Kang
repository: https://github.com/JeffGuKang/english-ssam
---

# English Ssam Plugin

This plugin provides English tutoring while you code. It checks your prompts for grammar errors and suggests improvements, with special focus on common mistakes made by Korean speakers.

## Plugin Structure

```
plugin/english-ssam/
├── plugin.md    # This file - plugin metadata and entry point
├── skill.md     # Behavior rules for English correction
└── command.md   # Slash command definitions
```

## Features

- **Real-time English correction** for every prompt
- **Multiple modes**: check, confirm, auto, silent
- **Korean speaker focus**: articles, prepositions, plurals, word order
- **Slash commands** for toggling and configuration

## Commands

| Command | Action |
|---------|--------|
| `/english-ssam` | Toggle ON/OFF |
| `/english-ssam check` | Check Mode (default) |
| `/english-ssam confirm` | Confirm Mode |
| `/english-ssam auto` | Auto Mode |
| `/english-ssam silent` | Silent Mode |
| `/english-ssam status` | Show current state |
| `/english-ssam update` | Update to latest version |

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

## Usage

Once installed, type `/english-ssam` to activate. The tutor will check your English in every subsequent message.

## License

MIT
