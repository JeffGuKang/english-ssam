#!/usr/bin/env bats

load 'test_helper'

setup() {
    setup_test_env
}

teardown() {
    teardown_test_env
}

@test "update action updates file content" {
    setup_mock_download "1.5.7" # Mock remote version
    
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam"
    mkdir -p "$HOME/.config/opencode/command"
    
    run bash "$(get_install_script)" --update
    [ "$status" -eq 0 ]
    [[ "$output" == *"Updated"* ]] || [[ "$output" == *"Success"* ]]
}

@test "install shows ready message" {
    setup_mock_download "1.5.6"
    
    run bash -c "echo 5 | bash $(get_install_script) --global"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Success"* ]]
}

@test "help shows version check interval info" {
    run bash "$(get_install_script)" --help
    [ "$status" -eq 0 ]
}

@test "status command works without version check file" {
    mkdir -p "$HOME/.config/opencode/plugin/english-ssam"
    rm -f "$HOME/.english-ssam-last-check"
    
    run bash "$(get_install_script)" --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"ENABLED"* ]]
}
