# 🎓 English Ssam (英语老师)

> 您的友好英语辅助工具，适配 [OpenCode](https://opencode.ai) 及其他 AI 编程助手 —— 在编程的同时提升您的英语水平！

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**"Ssam" (쌤)** 是韩语中“老师” (선생님) 的俚语用法。这个插件充当您的私人英语老师，在执行指令之前纠正并改进您的 Prompt。

## 简介

English Ssam 旨在帮助开发者在与 AI 交流的过程中学习更地道、更准确的英语。它不仅会纠正语法错误，还会解释原因，帮助您在潜移默化中提高英语表达能力。

## ✨ 功能特点

- **实时纠错**：检查并改进您的每一个 Prompt。
- **清晰解释**：告诉您为什么要这样修改，让您真正理解语法规则。
- **针对性优化**：特别关注中文/韩语使用者常见的英语错误。
- **鼓励式教学**：营造轻松的学习氛围，减少语言焦虑。
- **定期小贴士**：随机分享词汇和语法干货。

## 🛠 支持的 AI 工具

English Ssam 支持多种主流 AI 编程助手：

- **OpenCode**
- **Cursor**
- **Claude Code CLI**
- **GitHub Copilot**
- **Windsurf**
- **Aider**
- **Continue.dev**
- **Zed**

## 🚀 快速安装

### 使用 AI 提示安装（最简单！）

只需告诉您的 AI 助手：

```
install english-ssam locally
```

或者

```
安装English Ssam
```

AI 将自动运行正确的安装命令。

### 使用终端安装

使用以下一键安装命令。请根据您使用的工具选择对应的命令：

### OpenCode (全局)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

### Cursor (当前项目)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local
```

### Claude Code (当前项目)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=claude-code --local
```

### GitHub Copilot (当前项目)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=copilot --local
```

### Windsurf (当前项目)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=windsurf --local
```

### Aider (全局)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=aider --global
```

### Continue.dev (全局)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=continue --global
```

### Zed (当前项目)
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=zed --local
```

## ✨ 您将看到的效果

当您输入一个带有语法错误的 Prompt 时，AI 助手会先为您提供简要的英语检查，然后再执行您的请求：

```markdown
## 🎓 English Check (英语检查)

**您的 Prompt:** "I want make new function for calculate price"

**改进建议:** "I want to make a new function to calculate the price"

| 原句 (Original) | 修改后 (Corrected) | 原因 (Why) |
| --------------- | ---------------- | ---------- |
| "want make"     | "want to make"   | "want" 后面需要跟 "to" + 动词原形 |
| "new function"  | "a new function" | 需要使用冠词 "a" |
| "for calculate" | "to calculate"   | 表示目的时通常使用 "to" |
| "price"         | "the price"      | 特指某个价格时需要使用 "the" |
```

---

## 🎯 中文使用者重点关注领域

针对中文母语者的常见错误，English Ssam 会重点关注以下方面：

### 冠词 (a/an/the)
中文没有冠词，这通常是最大的挑战：
- ❌ "I have computer" -> ✅ "I have **a** computer"
- ❌ "Sun is bright" -> ✅ "**The** sun is bright"

### 介词 (in/on/at/to/for)
英语介词用法复杂，且往往与中文直译不符：
- ❌ "I'm good in coding" -> ✅ "I'm good **at** coding"
- ❌ "Wait me" -> ✅ "Wait **for** me"

### 复数形式
中文不通过词尾变化标记复数，容易被遗忘：
- ❌ "I have many friend" -> ✅ "I have many friend**s**"
- ❌ "Two file" -> ✅ "Two file**s**"

### 时态 (Verb Tenses)
中文动词没有位格和时态变化：
- ❌ "I go there yesterday" -> ✅ "I **went** there yesterday"
- ❌ "He like coding" -> ✅ "He **likes** coding" (第三人称单数)

### 语序 (Word Order)
虽然英语和中文都是 SVO (主-谓-宾) 结构，但在状语（时间、地点）的摆放位置上存在差异：
- ❌ "I yesterday deleted the file" -> ✅ "I deleted the file **yesterday**"

## 🛠 手动安装方法

如果您不想使用脚本，可以手动安装：

1. 下载 [ENGLISH_SSAM.md](https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/ENGLISH_SSAM.md) 文件。
2. 将其内容添加到您 AI 工具的“自定义指令” (Custom Instructions) 或对应的配置文件中。
   - **Cursor**: 放入 `.cursorrules`
   - **Claude Code**: 放入 `CLAUDE.md`
   - **GitHub Copilot**: 放入 `.github/copilot-instructions.md`

## 🔧 卸载方法

运行安装脚本并加上 `--uninstall` 参数：
```bash
curl -fsSL https://raw.githubusercontent.com/code-yeongyu/english-ssam/main/scripts/install.sh | bash -s -- --tool=TOOL --MODE --uninstall
```

## 🤝 贡献方式

欢迎提交 Pull Request 或 Issue！您可以：
- 提供更多针对中文使用者的英语学习建议。
- 改进纠错提示词的准确性。
- 适配更多 AI 工具。

## 📄 许可证

本项目采用 [MIT](LICENSE) 许可证。

© [Jeff Kang](https://github.com/code-yeongyu)

---

**为全球英语学习者用心打造 ❤️**
