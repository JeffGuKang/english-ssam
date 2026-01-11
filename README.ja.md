# 🎓 English Ssam (英語先生)

> **English Ssam** は、コーディング中に英語の文法や表現を改善してくれる、あなたのためのフレンドリーな英語チューターです。

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

---

## 💡 はじめに

**Ssam (쌤)** は、韓国語の「先生（선생님）」を親しみやすく呼ぶ際のスラングです。
このプロジェクトは、AIを活用したコーディングアシスタントを使用する開発者が、プロンプトを入力するたびに英語の添削を受け、自然に英語力を向上させることを目的としています。

コーディングを止めることなく、あなたの英語をより自然で正確なものへと導きます。

## 🛠 対応AIツール

English Ssam は、以下の主要なAIコーディングツールに対応しています。

- **OpenCode**
- **Cursor**
- **Claude Code CLI**
- **GitHub Copilot**
- **Windsurf**
- **Aider**
- **Continue.dev**
- **Zed**

## 🚀 クイックインストール

### AIプロンプトでインストール（最も簡単！）

AIアシスタントに以下のように伝えてください：

```
install english-ssam locally
```

または

```
English Ssamをインストールして
```

AIが自動的に適切なインストールコマンドを実行します。

### ターミナルでインストール

お使いのツールに合わせて、以下のコマンドをターミナルで実行してください。

### OpenCode
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

### Cursor
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local
```

### Claude Code CLI
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=claude-code --local
```

### GitHub Copilot
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=copilot --local
```

### Windsurf
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=windsurf --local
```

### Aider
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=aider --global
```

### Continue.dev
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=continue --global
```

### Zed
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=zed --local
```

## 📝 使用例

AIへの依頼を行うと、回答の冒頭で以下のような添削結果が表示されます。

```markdown
## 🎓 English Check

**Your prompt:** "I want make new function for calculate price"

**Suggested revision:** "I want to make a new function to calculate the price"

| Original        | Corrected        | Why                         |
| --------------- | ---------------- | --------------------------- |
| "want make"     | "want to make"   | "want" は "to" + 動詞が必要 |
| "new function"  | "a new function" | 冠詞 "a" が必要             |
| "for calculate" | "to calculate"   | 目的を表すには "to" を使用  |
| "price"         | "the price"      | 特定の価格には "the" が必要 |
```

## 🎯 日本語話者向けの重点エリア

日本語と英語の構造的な違いから、日本の開発者が間違いやすいポイントを重点的にサポートします。

| カテゴリ | 内容 | 理由 |
| :--- | :--- | :--- |
| **冠詞 (a/an/the)** | 適切な冠詞の使用 | 日本語には冠詞が存在しないため |
| **前置詞 (in/on/at)** | 正しい前置詞の選択 | 日本語の助詞（に、で、へ）とは論理が異なるため |
| **複数形** | 単数・複数の区別 | 日本語は通常、名詞の複数形を明示しないため |
| **語順 (SVO)** | 正しい文構造 | 日本語は SOV ですが、英語は SVO のため |

## 📦 手動インストール方法

リポジトリをクローンして手動で設定する場合：

```bash
git clone https://github.com/JeffGuKang/english-ssam.git
cd english-ssam
# 各ツールの設定ディレクトリに skill/english-ssam.md をコピーしてください
```

## 🔧 アンインストール方法

インストール時に作成された設定を削除するには、以下のコマンドを実行してください。

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --uninstall
```

## 🤝 貢献方法

プロジェクトへの貢献を歓迎します！

- バグ報告や機能要望は Issue まで
- 改善提案は Pull Request をお送りください
- 日本語話者特有の「英語あるある」な間違いの追加も大歓迎です

## 📄 ライセンス

[MIT License](LICENSE) © [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)

---

**日本のエンジニアの皆さんの英語学習を応援しています！**

頑張りましょう！ 💪
