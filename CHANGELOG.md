# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [1.8.1](https://github.com/JeffGuKang/english-ssam/compare/v1.8.0...v1.8.1) (2026-01-19)


### Bug Fixes

* embed full command content and remove invalid --tool flag ([3853410](https://github.com/JeffGuKang/english-ssam/commit/38534108bf4673d2a4355b85fc9b7268ea43c400))

## 1.8.0 (2026-01-15)


### Features

* add automated test suite with BATS and GitHub Actions CI ([8126f10](https://github.com/JeffGuKang/english-ssam/commit/8126f10094737adbe792d5df84ba2da4699870ea))
* add Codex CLI support ([2e6eff5](https://github.com/JeffGuKang/english-ssam/commit/2e6eff5810ab6d7911d7ea4c77f7d4640d2db708))
* add mode support (check, confirm, auto, silent) for English Ssam ([7f4bde6](https://github.com/JeffGuKang/english-ssam/commit/7f4bde6b4f5c5050458f7f8bd086e5b40e5f4a16))
* add multi-tool support with toggle slash command ([5777849](https://github.com/JeffGuKang/english-ssam/commit/5777849f82ea5b900f1f0362f5ceaea13cfd5fcd))
* add update command support ([2f3803c](https://github.com/JeffGuKang/english-ssam/commit/2f3803ccc7d515e45da6efe32b9ec1f9ddb15491))
* add update command to /english-ssam ([fd83da5](https://github.com/JeffGuKang/english-ssam/commit/fd83da5b7fa0c7b7a29c70ac0ebb2235b34af2ea))
* add weekly version check with update notification ([f565c96](https://github.com/JeffGuKang/english-ssam/commit/f565c962818ed92d88a6e6ccba94fd488f5a2e04))
* **command:** add update subcommand support ([5898026](https://github.com/JeffGuKang/english-ssam/commit/589802669a950870507f8afd64943f42be966754))
* default state is ON after global install ([a569b8f](https://github.com/JeffGuKang/english-ssam/commit/a569b8ff9175f659a2146836703d4aa0cfce93f3))
* improve plugin status message with mode information ([093325f](https://github.com/JeffGuKang/english-ssam/commit/093325fa1e243e08be7549b537deca4dfa9eff82))
* migrate to plugin architecture for OpenCode and Continue ([e887d9a](https://github.com/JeffGuKang/english-ssam/commit/e887d9ac7c9ce1bd7e0974a36b43955d87e19d33))
* optimize for speed by forcing fast model selection ([7de0bb6](https://github.com/JeffGuKang/english-ssam/commit/7de0bb6e291a267a00aa105ee9c44099ecba96f2))
* prompt user to select fast model during first install ([f59e7e6](https://github.com/JeffGuKang/english-ssam/commit/f59e7e6f039760553d157d2cdba860a3f50876cd))
* refactor to support OpenCode only and rename to opencode-english-ssam ([f8e2369](https://github.com/JeffGuKang/english-ssam/commit/f8e2369b714cee79493478340869e4fd71aad681))
* support formal OpenCode plugin install via npm ([38aa317](https://github.com/JeffGuKang/english-ssam/commit/38aa3176171137177855952c5f4262343efe92ab))
* support jsonc config files for OpenCode ([45d69cd](https://github.com/JeffGuKang/english-ssam/commit/45d69cde84231f03387fed3c128b5bfc1f8f7d41))


### Bug Fixes

* **command:** add toggle logic and set fast model for english-ssam ([154d6c3](https://github.com/JeffGuKang/english-ssam/commit/154d6c3e56e80fb754ab0b2c6f6af697e6c7489b))
* **command:** improve argument parsing for mode and status subcommands ([060ba63](https://github.com/JeffGuKang/english-ssam/commit/060ba63143906cde2e107ada2fd1503afd2ef859))
* **command:** update english-ssam toggle logic ([917f7c0](https://github.com/JeffGuKang/english-ssam/commit/917f7c003cf7af63d11fec16bcc2d0d21367edb0))
* correct ASCII banner spelling from SPAM to SSAM ([31dbab5](https://github.com/JeffGuKang/english-ssam/commit/31dbab5afb460b3a9ea1c6d16f83e60500a224c8))
* exit with error status on unknown install options ([0610555](https://github.com/JeffGuKang/english-ssam/commit/06105559c04285cb40478a4ed77b157e68ad05af))
* OpenCode command location and simplify prompt format ([a528291](https://github.com/JeffGuKang/english-ssam/commit/a528291d4a3a86efd2e24d5a1c26025b3146a367))
* skip confirmation when English is perfect ([752709b](https://github.com/JeffGuKang/english-ssam/commit/752709ba21392dc0852197bc85e52cfcd3dd1ddd))

## [1.4.0] - 2026-01-11

### Added
- **Plugin architecture**: New plugin-based structure for better organization
  - OpenCode: `~/.config/opencode/plugin/english-ssam/`
  - Continue: `~/.continue/plugin/english-ssam/`
- **Plugin files**:
  - `plugin.md` - Plugin metadata and entry point
  - `skill.md` - Behavior rules for English correction
  - `command.md` - Slash command definitions

### Changed
- Migrated from `skill/` + `command/` to unified `plugin/` directory structure
- Updated install paths for OpenCode and Continue
- Improved disable/enable to support directory-based plugins

## [1.3.0] - 2026-01-11

### Added
- **Mode support**: New correction modes for different workflows
  - `check` - Show corrections, execute immediately (default)
  - `confirm` - Show corrections, wait for user approval (Y/N/E)
  - `auto` - Show corrections, auto-proceed
  - `silent` - Fix silently, no display
- **New commands**:
  - `/english-ssam status` - Show current state and mode
  - `/english-ssam update` - Update to latest version
  - `/english-ssam [mode]` - Change correction mode
- **Automated test suite**: 32 BATS tests for install script
- **GitHub Actions CI**: Automated testing on Ubuntu and macOS
- **Behavior test cases**: 57 markdown test cases for AI behavior verification

### Changed
- Improved command argument parsing for subcommands
- Enhanced activation message with mode information

## [1.2.0] - 2026-01-10

### Added
- Weekly automatic version check with update notification
- `/english-ssam update` natural language trigger
- Update notification banner when new version available
- Version check timestamp stored in `~/.english-ssam-last-check`

### Changed
- Optimized for speed with fast model selection (Haiku, Flash, 4o-mini)

## [1.1.0] - 2026-01-09

### Added
- Toggle command (`/english-ssam`) to enable/disable tutor mode
- State tracking across conversation
- Support for 8 AI tools: OpenCode, Cursor, Claude Code, GitHub Copilot, Windsurf, Aider, Continue, Zed
- Install script with `--enable`, `--disable`, `--status` flags
- Multi-language installation triggers (English, Korean, Japanese, Chinese)

## [1.0.0] - 2026-01-08

### Added
- Initial release
- English correction for every prompt
- Focus on Korean speaker patterns:
  - Articles (a/an/the)
  - Prepositions (in/on/at/to/for/with)
  - Plural forms
  - Word order (SVO vs SOV)
- Correction table format with explanations
- Install script for multiple AI tools
- README in 4 languages (English, Korean, Japanese, Chinese)
