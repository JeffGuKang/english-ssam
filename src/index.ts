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

const ensureCommand = () => {
  const configDir = join(homedir(), ".config/opencode/command");
  const commandFile = join(configDir, "english-ssam.md");
  
  if (!existsSync(commandFile)) {
    try {
      if (!existsSync(configDir)) {
        mkdirSync(configDir, { recursive: true });
      }
      const content = "---\ndescription: Toggle English Ssam on/off\n---\n/english-ssam $ARGUMENTS\n";
      writeFileSync(commandFile, content);
      console.log("English Ssam: Registered /english-ssam command");
    } catch (e) {
      console.error("English Ssam: Failed to register command file", e);
    }
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
