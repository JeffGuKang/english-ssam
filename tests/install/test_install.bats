#!/usr/bin/env bats
# Main install script tests for OpenCode English Ssam

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
}

@test "unknown option shows error" {
    run bash "$(get_install_script)" --unknown-flag
    [ "$status" -eq 1 ]
}

# ====================
# OpenCode Tests
# ====================

@test "opencode install creates plugin directory" {
    setup_mock_download "# English Ssam Test Content"
    
    # Use bash -c to handle the model selection prompt via pipe
    run bash -c "echo 5 | bash $(get_install_script) --global"
    [ "$status" -eq 0 ]
    [ -d "$HOME/.config/opencode/plugin/english-ssam" ]
    [ -f "$HOME/.config/opencode/plugin/english-ssam/plugin.md" ]
    [ -f "$HOME/.config/opencode/plugin/english-ssam/skill.md" ]
    [ -f "$HOME/.config/opencode/command/english-ssam.md" ]
}

@test "opencode uninstall removes plugin directory" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam"
    mkdir -p "$HOME/.config/opencode/command"
    echo "test" > "$HOME/.config/opencode/plugin/english-ssam/plugin.md"
    echo "test" > "$HOME/.config/opencode/plugin/english-ssam/skill.md"
    echo "test" > "$HOME/.config/opencode/command/english-ssam.md"
    
    run bash "$(get_install_script)" --uninstall
    [ "$status" -eq 0 ]
    [ ! -d "$HOME/.config/opencode/plugin/english-ssam" ]
    [ ! -f "$HOME/.config/opencode/command/english-ssam.md" ]
}

@test "opencode disable creates backup" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam"
    echo "test" > "$HOME/.config/opencode/plugin/english-ssam/plugin.md"
    
    run bash "$(get_install_script)" --disable
    [ "$status" -eq 0 ]
    [ ! -d "$HOME/.config/opencode/plugin/english-ssam" ]
    [ -d "$HOME/.config/opencode/plugin/english-ssam.disabled" ]
}

@test "opencode enable restores from backup" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam.disabled"
    echo "test content" > "$HOME/.config/opencode/plugin/english-ssam.disabled/plugin.md"
    
    run bash "$(get_install_script)" --enable
    [ "$status" -eq 0 ]
    [ -d "$HOME/.config/opencode/plugin/english-ssam" ]
    [ ! -d "$HOME/.config/opencode/plugin/english-ssam.disabled" ]
}

@test "opencode status shows enabled" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam"
    
    run bash "$(get_install_script)" --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"ENABLED"* ]]
}

@test "opencode status shows disabled" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam.disabled"
    
    run bash "$(get_install_script)" --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"DISABLED"* ]]
}

@test "opencode status shows not installed" {
    run bash "$(get_install_script)" --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"NOT INSTALLED"* ]]
}
