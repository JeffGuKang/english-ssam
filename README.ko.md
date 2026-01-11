# 🎓 English Ssam (영어 쌤)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

> **AI 코딩 어시스턴트와 함께 코딩하면서 영어를 배우세요!**

**영어 쌤(Ssam)**은 한국어에서 '선생님'을 친근하게 부르는 줄임말입니다. 이 프로젝트는 여러분이 AI 도구에 입력하는 프롬프트를 실행하기 전에 영어 문법을 교정하고 더 나은 표현을 제안해 주는 여러분만의 개인 영어 튜터 역할을 합니다.

## ✨ 주요 특징

- **실시간 교정**: 모든 프롬프트를 체크하고 더 자연스러운 영어로 개선해 줍니다.
- **명확한 설명**: 단순히 고쳐주는 것이 아니라, *왜* 그 표현이 더 좋은지 설명해 줍니다.
- **한국어 사용자 맞춤형**: 한국인 개발자들이 자주 실수하는 부분을 집중적으로 관리합니다.
- **격려하는 어조**: 스트레스 없이 즐겁게 영어를 배울 수 있도록 도와줍니다.
- **주기적인 팁**: 유용한 단어와 문법 팁을 3~5번의 대화마다 제공합니다.

## 🛠 지원하는 AI 도구

English Ssam은 다음 도구들을 지원합니다:

- **OpenCode**
- **Cursor**
- **Claude Code CLI**
- **GitHub Copilot**
- **Windsurf**
- **Aider**
- **Continue.dev**
- **Zed**

## 📦 빠른 설치 (Quick Install)

### AI 프롬프트로 설치 (가장 쉬운 방법!)

AI 어시스턴트에게 다음과 같이 말하세요:

```
영어쌤 설치해줘
```

또는

```
잉글리쉬쌤 로컬에 설치해줘
```

AI가 자동으로 적절한 설치 명령어를 실행합니다.

### 터미널에서 설치

터미널에서 아래의 원라이너(One-liner) 명령어를 실행하여 바로 설치할 수 있습니다.

### OpenCode (전역 설치)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=opencode --global
```

### Cursor (현재 프로젝트)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local
```

### Claude Code CLI (현재 프로젝트)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=claude-code --local
```

### GitHub Copilot (현재 프로젝트)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=copilot --local
```

### Windsurf (현재 프로젝트)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=windsurf --local
```

### Aider (전역 설치)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=aider --global
```

### Continue.dev (전역 설치)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=continue --global
```

### Zed (현재 프로젝트)
```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=zed --local
```

## 🚀 사용 예시

설치 후 AI에게 질문을 하면, 모든 답변의 시작 부분에 다음과 같은 **English Check** 섹션이 나타납니다:

```markdown
## 🎓 English Check

**Your prompt:** "I want make new function for calculate price"

**Suggested revision:** "I want to make a new function to calculate the price"

| 원문 (Original) | 교정 (Corrected) | 이유 (Why) |
| --------------- | ---------------- | --------------------------- |
| "want make"     | "want to make"   | "want" 뒤에는 "to" + 동사 원형이 필요합니다 |
| "new function"  | "a new function" | 관사 "a"가 필요합니다 |
| "for calculate" | "to calculate"   | 목적을 나타낼 때는 "to"를 사용하세요 |
| "price"         | "the price"      | 특정한 가격을 언급할 때는 "the"가 필요합니다 |
```

## 🎯 한국어 사용자를 위한 중점 영역

| 항목 | 예시 | 한국인에게 어려운 이유 |
| --- | --- | --- |
| **관사 (Articles)** | a/an/the | 한국어에는 없는 개념이라 가장 많이 실수합니다 |
| **전치사 (Prepositions)** | in/on/at | 한국어의 조사(~에, ~에서)와 일대일로 매칭되지 않습니다 |
| **복수형 (Plurals)** | file → files | 한국어는 복수 표현을 엄격하게 구분하지 않는 경우가 많습니다 |
| **어순 (Word Order)** | SVO vs SOV | 한국어(주어-목적어-동사)와 영어(주어-동사-목적어)의 근본적 차이 |

## 🛠 수동 설치 방법

자동 설치 스크립트를 사용하지 않으려면, 프로젝트 루트에 있는 `ENGLISH_SSAM.md` 파일의 내용을 복사하여 각 도구의 시스템 프롬프트 설정이나 프로젝트 규칙 파일(`.cursorrules`, `CLAUDE.md` 등)에 직접 추가하세요.

## 🔧 제거 방법

설치 시 사용했던 명령어 뒤에 `--uninstall` 옵션을 붙여 실행하세요.

```bash
# 예: Cursor에서 제거
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --tool=cursor --local --uninstall
```

## 🤝 기여하기

프로젝트 개선을 위한 모든 기여를 환영합니다!
- 새로운 언어(일본어, 중국어 등) 맞춤형 팁 추가
- 자주 하는 실수 데이터베이스 확장
- 다양한 AI 도구와의 통합 개선

## 📄 라이선스

MIT © [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)

---

**전 세계 모든 영어 학습자들을 위해 ❤️로 만들었습니다.**

코딩도 영어 공부도 화이팅! 💪
