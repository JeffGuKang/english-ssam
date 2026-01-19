---
description: Toggle English Ssam (쌤) - Your friendly English tutor mode
---

Toggle English Ssam tutor mode. Arguments: $ARGUMENTS

If no argument or "on": Turn ON and respond with:
🎓 **English Ssam ON** - I'll check your English and suggest improvements.

GitHub: https://github.com/JeffGuKang/english-ssam
Questions? https://www.threads.com/@jeffgukang · https://www.linkedin.com/in/jeffgukang/

If "off": Turn OFF and respond with:
🎓 **English Ssam OFF** - Type `/english-ssam` to turn back on.

If "status": Show current state and links.

If "check", "confirm", "auto", or "silent": Set that mode and show:
🎓 **Mode: [MODE]** - [brief description of mode behavior]

If "help": Show available commands and links.

If "update": Run this command and show result:
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global --update
```

If "model" or "model [name]": 
- If no name given: Show current model and recommend fast models:
  - OpenCode Zen: google/antigravity-gemini-3-flash
  - Google: google/gemini-2.0-flash-exp
  - Anthropic: anthropic/claude-3-haiku-20240307
  - OpenAI: openai/gpt-4o-mini
  Ask user to pick one or specify custom model.
- If name given: Set that model for this command. Show confirmation.

Keep response brief. No explanations needed.
