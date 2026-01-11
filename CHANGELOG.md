# Changelog

All notable changes to English Ssam will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
