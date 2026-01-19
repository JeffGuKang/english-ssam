import type { Plugin } from "@opencode-ai/plugin";
import { readFileSync, existsSync, mkdirSync, writeFileSync } from "fs";
import { join } from "path";
import { homedir } from "os";

let enabled = true;
let mode = "check";

const skillPath = join(__dirname, "../plugin/english-ssam/skill.md");
let skillContent = "";
try {
  skillContent = readFileSync(skillPath, "utf8");
} catch (e) {
  console.error("English Ssam: Could not load skill.md", e);
}

const commandContent = `---
description: Toggle English Ssam (쌤) - Your friendly English tutor mode
---

Toggle English Ssam tutor mode. Arguments: $ARGUMENTS

If no argument or "on": Turn ON and respond with:
🎓 **English Ssam ON** - I'll check your English and suggest improvements.

GitHub: https://github.com/JeffGuKang/english-ssam
Questions? https://www.threads.com/@jeffgukang · https://www.linkedin.com/in/jeffgukang/

If "off": Turn OFF and respond with:
🎓 **English Ssam OFF** - Type \`/english-ssam\` to turn back on.

If "status": Show current state and links.

If "check", "confirm", "auto", or "silent": Set that mode and show:
🎓 **Mode: [MODE]** - [brief description of mode behavior]

If "help": Show available commands and links.

If "update": Run this command and show result:
\`\`\`bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global --update
\`\`\`

If "model" or "model [name]": 
- If no name given: Show current model and recommend fast models:
  - OpenCode Zen: google/antigravity-gemini-3-flash
  - Google: google/gemini-2.0-flash-exp
  - Anthropic: anthropic/claude-3-haiku-20240307
  - OpenAI: openai/gpt-4o-mini
  Ask user to pick one or specify custom model.
- If name given: Set that model for this command. Show confirmation.

Keep response brief. No explanations needed.
`;

const ensureCommand = () => {
  const configDir = join(homedir(), ".config/opencode/command");
  const commandFile = join(configDir, "english-ssam.md");
  
  try {
    if (!existsSync(configDir)) {
      mkdirSync(configDir, { recursive: true });
    }
    // Always update command file to ensure latest version
    writeFileSync(commandFile, commandContent);
    console.log("English Ssam: Registered /english-ssam command");
  } catch (e) {
    console.error("English Ssam: Failed to register command file", e);
  }
};

const getStatusMessage = () => {
  const status = enabled ? "ON" : "OFF";
  let msg = `# 🎓 English Ssam is now **${status}**!\n\n`;
  
  if (enabled) {
    msg += `Current Mode: **${mode}**\n\n`;
    msg += `### Available Modes\n`;
    msg += `- \`/english-ssam check\`: Show corrections, execute immediately (default)\n`;
    msg += `- \`/english-ssam confirm\`: Wait for your approval before execution\n`;
    msg += `- \`/english-ssam auto\`: Show corrections and auto-proceed\n`;
    msg += `- \`/english-ssam silent\`: Apply corrections without displaying them\n\n`;
    msg += `### Other Commands\n`;
    msg += `- \`/english-ssam status\`: Show current configuration\n`;
    msg += `- \`/english-ssam off\`: Turn off tutor mode\n`;
  } else {
    msg += `Type \`/english-ssam\` anytime to turn it back on!`;
  }
  
  return msg;
};

export const EnglishSsamPlugin: Plugin = async ({ client }) => {
  console.log("English Ssam: Plugin loaded!");
  ensureCommand();
  
  return {
    "tui.prompt.append": async (input, output) => {
      if (enabled && skillContent) {
        output.prompt += `\n\n${skillContent}\n\nSelected Mode: ${mode}`;
      }
    },
    "tui.command.execute": async (input, output) => {
      const parts = input.line.split(" ");
      const cmd = parts[0];
      const arg = parts[1];

      if (cmd === "/english-ssam") {
        if (arg === "off") {
          enabled = false;
        } else if (arg === "on") {
          enabled = true;
        } else if (["check", "confirm", "auto", "silent"].includes(arg)) {
          enabled = true;
          mode = arg;
        } else if (arg === "status") {
          
        } else {
          enabled = !enabled;
        }
        
        output.message = getStatusMessage();
        return { handled: true };
      }
    }
  };
};

export default EnglishSsamPlugin;
