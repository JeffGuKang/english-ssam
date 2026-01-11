---
description: Toggle English Ssam (쌤) - Your friendly English tutor mode
model: opencode/grok-code
---

# English Ssam Command

Parse the user's command and execute the appropriate action.

## Command Routing

| Input | Action |
|-------|--------|
| `/english-ssam` | Toggle ON/OFF |
| `/english-ssam on` | Turn ON |
| `/english-ssam off` | Turn OFF |
| `/english-ssam check` | Set Check Mode |
| `/english-ssam confirm` | Set Confirm Mode |
| `/english-ssam auto` | Set Auto Mode |
| `/english-ssam silent` | Set Silent Mode |
| `/english-ssam status` | Show Status |
| `/english-ssam update` | Update Plugin |
| `/english-ssam help` | Show Help |
| `/english-ssam [other]` | Show Error |

---

## State Tracking

Track these in conversation context:
- **state**: `on` or `off` (default: `off`)
- **mode**: `check`, `confirm`, `auto`, or `silent` (default: `check`)

---

## Messages

### ON Message

```
🎓 **English Ssam ON**

Mode: **{mode}**

I'll check your English and suggest improvements.

Commands: `/english-ssam off` · `/english-ssam [mode]` · `/english-ssam status`
```

### OFF Message

```
🎓 **English Ssam OFF**

Type `/english-ssam` to turn back on.
```

### Mode Changed Message

```
🎓 **Mode: {mode}**

{description}
```

Mode descriptions:
- **check**: Show corrections, then proceed
- **confirm**: Show corrections, wait for Y/N/E
- **auto**: Show corrections, auto-proceed
- **silent**: Fix silently, no display

### Status Message

```
🎓 **English Ssam Status**

State: **{on/off}**
Mode: **{mode}**

Modes: check · confirm · auto · silent
Commands: `/english-ssam [on|off|mode|status|help]`
```

### Help Message

```
🎓 **English Ssam Help**

**Toggle**
- `/english-ssam` - Toggle on/off
- `/english-ssam on` - Turn on
- `/english-ssam off` - Turn off

**Modes**
- `/english-ssam check` - Show corrections, proceed (default)
- `/english-ssam confirm` - Show corrections, wait for approval
- `/english-ssam auto` - Show corrections, auto-proceed
- `/english-ssam silent` - Fix silently

**Other**
- `/english-ssam status` - Show current state
- `/english-ssam update` - Update to latest version
- `/english-ssam help` - This help message
```

### Update Message

```
🔄 **Updating English Ssam...**
```

Then execute:
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global --update
```

After completion:
```
✅ **English Ssam Updated**

Restart your session to apply changes.
```

### Error Message

```
❌ **Unknown: /english-ssam {input}**

Try `/english-ssam help` for valid commands.
```

---

## Correction Formats

### Check Mode (default)

```
🎓 **English Check**

**You:** "{original}"
**Better:** "{corrected}"

{original phrase} → {corrected phrase} ({why})

---
```

Then proceed with task.

### Confirm Mode

```
🎓 **English Check**

**You:** "{original}"
**Better:** "{corrected}"

{original phrase} → {corrected phrase} ({why})

**Proceed with corrected version?** [Y / N / E]
```

Wait for response:
- **Y / yes / 예**: Use corrected, proceed
- **N / no / 아니**: Use original, proceed
- **E / edit / 수정**: Ask for edit

### Auto Mode

```
🎓 **English Check** (auto)

**You:** "{original}"
**Better:** "{corrected}"

---
```

Proceed immediately with corrected version.

### Silent Mode

No display. Use corrected version internally and proceed.

### Perfect English

```
🎓 Your English is perfect!

---
```

Then proceed with task.

---

## Toggle Logic

For `/english-ssam` (no argument):
1. Check current state from context
2. If `off` → set `on`, show ON message
3. If `on` → set `off`, show OFF message
