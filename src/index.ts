import type { Plugin } from "@opencode-ai/plugin";
import { readFileSync } from "fs";
import { join } from "path";

let enabled = true;

const skillPath = join(__dirname, "../plugin/english-ssam/skill.md");
let skillContent = "";
try {
  skillContent = readFileSync(skillPath, "utf8");
} catch (e) {
  console.error("English Ssam: Could not load skill.md", e);
}

export const EnglishSsamPlugin: Plugin = async ({ client }) => {
  return {
    "tui.prompt.append": async (input, output) => {
      if (enabled && skillContent) {
        output.prompt += `\n\n${skillContent}`;
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
        } else {
          enabled = !enabled;
        }
        
        const status = enabled ? "ON" : "OFF";
        output.message = `🎓 English Ssam is now **${status}**!`;
        return { handled: true };
      }
    }
  };
};

export default EnglishSsamPlugin;
