# 🎓 OpenCode English Ssam (쌤)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**OpenCode English Ssam (쌤)** is your friendly English tutor plugin for [OpenCode](https://github.com/OpenCode-AI/opencode). "Ssam" is Korean slang for "teacher" (선생님). This plugin transforms your AI assistant into a grammar-aware tutor that corrects and improves your English prompts while you code.

## 📦 Quick Install

Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global
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

## 🗑️ Uninstall

To remove the installation, run:

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --uninstall
```

## 🤝 Contributing

Contributions are welcome! If you have suggestions for new tips or focus areas, please open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
**Created by [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)**  
*Helping you code better and speak better.*
