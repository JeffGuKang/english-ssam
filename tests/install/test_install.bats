#!/usr/bin/env bats
# Main install script tests for English Ssam

# Load test helpers
load 'test_helper'

# Setup before each test
setup() {
    setup_test_env
}

# Teardown after each test
teardown() {
    teardown_test_env
}

# ====================
# Help and Basic Tests
# ====================

@test "help flag shows usage" {
    run bash "$(get_install_script)" --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"Usage:"* ]]
    [[ "$output" == *"--tool=TOOL"* ]]
}

@test "missing tool shows error" {
    run bash "$(get_install_script)" --local
    [ "$status" -eq 1 ]
}

@test "missing mode shows error" {
    run bash "$(get_install_script)" --tool=cursor
    [ "$status" -eq 1 ]
    [[ "$output" == *"--global or --local"* ]]
}

@test "invalid tool shows error" {
    run bash "$(get_install_script)" --tool=invalid --local
    [ "$status" -eq 1 ]
    [[ "$output" == *"Unknown tool"* ]]
}

@test "unknown option shows error" {
    run bash "$(get_install_script)" --unknown-flag
    [ "$status" -eq 1 ]
    [[ "$output" == *"Unknown option"* ]]
}

# ====================
# Cursor Tests
# ====================

@test "cursor install creates .cursorrules" {
    # Setup mock download
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=cursor --local
    [ "$status" -eq 0 ]
    [ -f ".cursorrules" ]
}

@test "cursor uninstall removes .cursorrules" {
    # Create the file first
    echo "test" > ".cursorrules"
    
    run bash "$(get_install_script)" --tool=cursor --local --uninstall
    [ "$status" -eq 0 ]
    [ ! -f ".cursorrules" ]
}

@test "cursor disable creates backup" {
    # Create the file first
    echo "test" > ".cursorrules"
    
    run bash "$(get_install_script)" --tool=cursor --local --disable
    [ "$status" -eq 0 ]
    [ ! -f ".cursorrules" ]
    [ -f ".cursorrules.disabled" ]
}

@test "cursor enable restores from backup" {
    # Create disabled backup
    echo "test content" > ".cursorrules.disabled"
    
    run bash "$(get_install_script)" --tool=cursor --local --enable
    [ "$status" -eq 0 ]
    [ -f ".cursorrules" ]
    [ ! -f ".cursorrules.disabled" ]
}

@test "cursor status shows enabled" {
    echo "test" > ".cursorrules"
    
    run bash "$(get_install_script)" --tool=cursor --local --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"ENABLED"* ]]
}

@test "cursor status shows disabled" {
    echo "test" > ".cursorrules.disabled"
    
    run bash "$(get_install_script)" --tool=cursor --local --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"DISABLED"* ]]
}

@test "cursor status shows not installed" {
    run bash "$(get_install_script)" --tool=cursor --local --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"NOT INSTALLED"* ]]
}

# ====================
# OpenCode Tests
# ====================

@test "opencode install creates skill and command files" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=opencode --global
    [ "$status" -eq 0 ]
    [ -f "$HOME/.config/opencode/skill/english-ssam.md" ]
    [ -f "$HOME/.config/opencode/command/english-ssam.md" ]
}

@test "opencode uninstall removes files" {
    mkdir -p "$HOME/.config/opencode/skill" "$HOME/.config/opencode/command"
    echo "test" > "$HOME/.config/opencode/skill/english-ssam.md"
    echo "test" > "$HOME/.config/opencode/command/english-ssam.md"
    
    run bash "$(get_install_script)" --tool=opencode --global --uninstall
    [ "$status" -eq 0 ]
    [ ! -f "$HOME/.config/opencode/skill/english-ssam.md" ]
    [ ! -f "$HOME/.config/opencode/command/english-ssam.md" ]
}

# ====================
# Claude Code Tests
# ====================

@test "claude-code install creates CLAUDE.md" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=claude-code --local
    [ "$status" -eq 0 ]
    [ -f "CLAUDE.md" ]
}

@test "claude-code uninstall removes CLAUDE.md" {
    echo "test" > "CLAUDE.md"
    
    run bash "$(get_install_script)" --tool=claude-code --local --uninstall
    [ "$status" -eq 0 ]
    [ ! -f "CLAUDE.md" ]
}

# ====================
# Copilot Tests
# ====================

@test "copilot install creates .github/copilot-instructions.md" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=copilot --local
    [ "$status" -eq 0 ]
    [ -d ".github" ]
    [ -f ".github/copilot-instructions.md" ]
}

@test "copilot uninstall removes file" {
    mkdir -p ".github"
    echo "test" > ".github/copilot-instructions.md"
    
    run bash "$(get_install_script)" --tool=copilot --local --uninstall
    [ "$status" -eq 0 ]
    [ ! -f ".github/copilot-instructions.md" ]
}

# ====================
# Windsurf Tests
# ====================

@test "windsurf install creates .windsurfrules" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=windsurf --local
    [ "$status" -eq 0 ]
    [ -f ".windsurfrules" ]
}

@test "windsurf uninstall removes file" {
    echo "test" > ".windsurfrules"
    
    run bash "$(get_install_script)" --tool=windsurf --local --uninstall
    [ "$status" -eq 0 ]
    [ ! -f ".windsurfrules" ]
}

# ====================
# Aider Tests
# ====================

@test "aider global install creates files" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=aider --global
    [ "$status" -eq 0 ]
    [ -f "$HOME/.aider-english-ssam.md" ]
    [ -f "$HOME/.aider.conf.yml" ]
}

@test "aider local install creates files in project" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=aider --local
    [ "$status" -eq 0 ]
    [ -f ".aider-english-ssam.md" ]
    [ -f ".aider.conf.yml" ]
}

@test "aider config contains read entry" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=aider --local
    [ "$status" -eq 0 ]
    grep -q "english-ssam" ".aider.conf.yml"
}

# ====================
# Continue Tests
# ====================

@test "continue install creates file" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=continue --global
    [ "$status" -eq 0 ]
    [ -f "$HOME/.continue/english-ssam.md" ]
}

@test "continue uninstall removes file" {
    mkdir -p "$HOME/.continue"
    echo "test" > "$HOME/.continue/english-ssam.md"
    
    run bash "$(get_install_script)" --tool=continue --global --uninstall
    [ "$status" -eq 0 ]
    [ ! -f "$HOME/.continue/english-ssam.md" ]
}

# ====================
# Zed Tests
# ====================

@test "zed install creates .zed/prompt.md" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=zed --local
    [ "$status" -eq 0 ]
    [ -d ".zed" ]
    [ -f ".zed/prompt.md" ]
}

@test "zed uninstall removes file" {
    mkdir -p ".zed"
    echo "test" > ".zed/prompt.md"
    
    run bash "$(get_install_script)" --tool=zed --local --uninstall
    [ "$status" -eq 0 ]
    [ ! -f ".zed/prompt.md" ]
}
