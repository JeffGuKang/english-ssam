# 🎓 OpenCode 영어 쌤 (English Ssam)

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [中文](README.zh.md)

**OpenCode 영어 쌤(Ssam)**은 [OpenCode](https://github.com/OpenCode-AI/opencode)를 위한 친근한 영어 튜터 플러그인입니다. "쌤(Ssam)"은 한국어에서 '선생님'을 친근하게 부르는 줄임말입니다. 이 플러그인은 여러분이 코딩하면서 AI에게 입력하는 프롬프트의 문법을 교정하고 더 나은 영어 표현을 제안해 주는 개인 영어 선생님 역할을 합니다.

## 📦 빠른 설치

터미널에서 아래 명령어를 실행하세요:

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --global
```

## ✨ 주요 특징

모든 질문을 할 때, AI 어시스턴트가 답변을 시작하기 전에 다음과 같은 **English Check** 섹션을 제공합니다:

### 🎓 English Check

**Your prompt:** "I want make new function for calculate price"

**Suggested revision:** "I want to make a new function to calculate the price"

| 원문 (Original) | 교정 (Corrected) | 이유 (Why) |
|----------|-----------|-----|
| want make | want to make | "want" 뒤에는 "to" + 동사 원형이 필요합니다 |
| new function | a new function | 관사 "a"가 필요합니다 |
| for calculate | to calculate | 목적을 나타낼 때는 "to"를 사용하세요 |
| price | the price | 특정한 가격을 언급할 때는 "the"가 필요합니다 |

---

## 🎯 한국어 사용자 맞춤형 튜터링

영어 쌤은 한국인 개발자들이 자주 실수하는 부분을 집중적으로 관리합니다:

*   **관사 (a/an/the)**: 한국어에는 없는 개념이라 놓치기 쉬운 관사 사용법을 교정합니다.
*   **전치사**: 한국어의 조사(~에, ~에서)와 다른 영어 전치사(in/on/at) 사용법을 안내합니다.
*   **복수형**: "Two file" 대신 "Two files"와 같이 복수 표현을 잊지 않도록 도와줍니다.
*   **어순**: 한국어(SOV)와 다른 영어(SVO)의 어순 차이를 고려하여 문장을 다듬어 줍니다.

## 🗑️ 제거 방법

설치된 플러그인을 제거하려면 아래 명령어를 실행하세요:

```bash
curl -fsSL https://raw.githubusercontent.com/JeffGuKang/english-ssam/main/scripts/install.sh | bash -s -- --uninstall
```

## 🤝 기여하기

프로젝트 개선을 위한 모든 기여를 환영합니다! 새로운 팁이나 한국인에게 유용한 표현 제안이 있다면 Issue나 Pull Request를 남겨주세요.

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---
**제작: [Jeff Kang](https://www.linkedin.com/in/jeffgukang/)**  
*더 나은 코딩과 더 나은 영어를 위해.*
