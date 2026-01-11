---
name: english-ssam
description: English Ssam - Your friendly English tutor for AI coding assistants
version: 1.5.0
author: Jeff Kang
repository: https://github.com/JeffGuKang/english-ssam
---

# English Ssam Plugin

English tutoring while you code. Checks prompts for grammar errors with focus on Korean speaker mistakes.

## Installation (OpenCode)

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

## File Structure

After installation, files are placed in:
- `~/.config/opencode/command/english-ssam.md` - Slash command
- `~/.config/opencode/plugin/english-ssam/skill.md` - Behavior instructions

## Commands

| Command | Action |
|---------|--------|
| `/english-ssam` | Toggle ON/OFF |
| `/english-ssam check` | Check Mode (default) |
| `/english-ssam confirm` | Confirm Mode |
| `/english-ssam auto` | Auto Mode |
| `/english-ssam silent` | Silent Mode |
| `/english-ssam status` | Show current state |
| `/english-ssam help` | Show help |

## License

MIT
