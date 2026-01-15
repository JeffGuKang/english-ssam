# 🎓 OpenCode English Ssam (英语老师)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**OpenCode English Ssam (英语老师)** 是专为 [OpenCode](https://github.com/OpenCode-AI/opencode) 打造的友好英语辅助插件。"Ssam" (쌤) 是韩语中“老师” (선생님) 的俚语用法。该插件充当您的私人英语老师，在执行指令之前纠正并改进您的 Prompt。

## 📦 快速安装

在终端运行以下命令：

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global
```

## ✨ 功能特点

当您输入 Prompt 时，AI 助手会先为您提供简要的英语检查，然后再执行您的请求：

### 🎓 English Check (英语检查)

**您的 Prompt:** "I want make new function for calculate price"

**改进建议:** "I want to make a new function to calculate the price"

| 原句 (Original) | 修改后 (Corrected) | 原因 (Why) |
|----------|-----------|-----|
| want make | want to make | "want" 后面需要跟 "to" + 动词原形 |
| new function | a new function | 需要使用冠词 "a" |
| for calculate | to calculate | 表示目的时通常使用 "to" |
| price | the price | 特指某个价格时需要使用 "the" |

---

## 🗑️ 卸载方法

运行以下命令卸载插件：

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --uninstall
```

## 📄 许可证

本项目采用 MIT 许可证。

---
**作者: [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)**
