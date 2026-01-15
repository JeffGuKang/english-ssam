# 🎓 OpenCode English Ssam (先生)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**OpenCode English Ssam (先生)** は [OpenCode](https://github.com/OpenCode-AI/opencode) 用のフレンドリーな英語チュータープラグインです。 「Ssam（サム）」は韓国語で「先生」を意味する親しみのある表現です。 このプラグインは、コー딩中にAIに入力するプロンプトの文法を修正し、より良い英語表現を提案する個人チューターの役割を果たします。

## 📦 クイックインストール

ターミナルで以下のコマンドを実行してください：

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global
```

## ✨ 主な機能

AIに質問するたびに、回答の前に以下のような **English Check** セクションが表示されます。

### 🎓 English Check

**Your prompt:** "I want make new function for calculate price"

**Suggested revision:** "I want to make a new function to calculate the price"

| 原文 (Original) | 修正 (Corrected) | 理由 (Why) |
|----------|-----------|-----|
| want make | want to make | "want" の後は "to" + 動詞の原形が必要です |
| new function | a new function | 冠詞 "a" が必要です |
| for calculate | to calculate | 目的を表すときは "to" を使用します |
| price | the price | 特定の価格を指すときは "the" が必要です |

---

## 🗑️ アンインストール

プラグインを削除するには、以下のコマンドを実行してください：

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --uninstall
```

## 📄 ライセンス

このプロジェクトは MIT ライセンスの下で提供されています。

---
**作成者: [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)**
