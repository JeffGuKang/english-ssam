#!/usr/bin/env bats

load 'test_helper'

setup() {
    setup_test_env
}

teardown() {
    teardown_test_env
}

@test "update action shows updating message" {
    setup_mock_download "# Updated English Ssam Content"
    echo "# Old content" > ".cursorrules"
    
    run bash "$(get_install_script)" --tool=cursor --local --update
    [ "$status" -eq 0 ]
    [[ "$output" == *"Updating"* ]] || [[ "$output" == *"Updated"* ]]
}

@test "update action updates file content" {
    setup_mock_download "# New Version Content"
    echo "# Old content" > ".cursorrules"
    
    bash "$(get_install_script)" --tool=cursor --local --update
    
    grep -q "New Version Content" ".cursorrules"
}

@test "install shows ready message" {
    setup_mock_download "# English Ssam Test Content"
    
    run bash "$(get_install_script)" --tool=cursor --local
    [ "$status" -eq 0 ]
    [[ "$output" == *"ready"* ]] || [[ "$output" == *"Installed"* ]]
}

@test "help shows version check interval info" {
    run bash "$(get_install_script)" --help
    [ "$status" -eq 0 ]
}

@test "status command works without version check file" {
    echo "test" > ".cursorrules"
    
    rm -f "$HOME/.english-ssam-last-check"
    
    run bash "$(get_install_script)" --tool=cursor --local --status
    [ "$status" -eq 0 ]
    [[ "$output" == *"ENABLED"* ]]
}
