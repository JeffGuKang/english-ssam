# 🎓 English Ssam (쌤)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**English Ssam (쌤)** is your friendly English tutor for AI coding assistants. "Ssam" is Korean slang for "teacher" (선생님). This project provides a set of instructions that transform your AI assistant into a grammar-aware tutor that corrects and improves your English prompts while you code.

## 🚀 Supported AI Tools

| Tool | Mode | Description |
|------|------|-------------|
| **OpenCode** | Global | Integrates as a custom instruction or skill |
| **Cursor** | Local | Installed as `.cursorrules` in your project |
| **Claude Code CLI** | Local | Installed as `CLAUDE.md` in your project |
| **GitHub Copilot** | Local | Installed as `.github/copilot-instructions.md` |
| **Windsurf** | Local | Installed as `.windsurfrules` in your project |
| **Aider** | Global/Local | Integrates with `.aider.conf.yml` |
| **Continue.dev** | Global | Adds to `customInstructions` in `config.json` |
| **Zed** | Local | Installed as `.zed/prompt.md` |

## 📦 Quick Install

### Using AI Prompt (Easiest!)

Just tell your AI assistant:

```
Install english-ssam by following https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/README.md
```

or

```
install english-ssam for cursor
```

The AI will automatically run the correct installation command for your tool.

### Using Terminal

Run the following command in your terminal for your preferred tool:

### Cursor (Project Local)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local
```

### OpenCode (Global)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

### Claude Code CLI (Project Local)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=claude-code --local
```

### GitHub Copilot (Project Local)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=copilot --local
```

### Windsurf (Project Local)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=windsurf --local
```

### Aider (Global)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=aider --global
```

### Continue.dev (Global)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=continue --global
```

### Zed (Project Local)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=zed --local
```

## ✨ What You'll See

On every prompt, your AI assistant will provide a brief English check before executing your request:

### 🎓 English Check

**Your prompt:** "I want make new function for calculate price"

**Suggested revision:** "I want to make a new function to calculate the price"

| Original | Corrected | Why |
|----------|-----------|-----|
| want make | want to make | "want" requires "to" + verb |
| new function | a new function | Article "a" needed |
| for calculate | to calculate | Use "to" for purpose |
| price | the price | Specific price needs "the" |

---

## 🎯 Focus Areas for Korean Speakers

English Ssam focuses on common challenges for Korean speakers:

*   **Articles (a/an/the)**: Korean doesn't have articles, making them easy to miss.
*   **Prepositions**: Logic for "in/on/at" differs significantly from Korean.
*   **Plurals**: Korean often omits plural markers (e.g., "Two file" vs "Two files").
*   **Word Order**: English uses SVO (Subject-Verb-Object) while Korean uses SOV.

## 🛠️ Manual Installation

If you prefer to install manually, download the [ENGLISH_SSAM.md](https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/ENGLISH_SSAM.md) file and add its content to your AI assistant's system prompt or custom instructions.

## 🗑️ Uninstall

To remove the installation, add the `--uninstall` flag to the install command:

```bash
# Example for Cursor
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --uninstall
```

## 🤝 Contributing

Contributions are welcome! If you have suggestions for new tips or focus areas, please open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
**Created by [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)**  
*Helping you code better and speak better.*
