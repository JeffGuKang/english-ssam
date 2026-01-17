#!/usr/bin/env bats
# Command file structure tests for English Ssam

load 'test_helper'

# ====================
# Command File Structure Tests
# ====================

@test "command file exists" {
    [ -f "$(get_command_file)" ]
}

@test "command file has description frontmatter" {
    run cat "$(get_command_file)"
    [[ "$output" == *"description:"* ]]
}

@test "command file documents toggle behavior" {
    run cat "$(get_command_file)"
    [[ "$output" == *"Toggle English Ssam"* ]]
}

# ====================
# Toggle Command Tests
# ====================

@test "command supports 'on' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"on"* ]] || [[ "$output" == *"ON"* ]]
}

@test "command supports 'off' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"off"* ]] || [[ "$output" == *"OFF"* ]]
}

@test "command shows ON message format" {
    run cat "$(get_command_file)"
    [[ "$output" == *"English Ssam ON"* ]]
}

@test "command shows OFF message format" {
    run cat "$(get_command_file)"
    [[ "$output" == *"English Ssam OFF"* ]]
}

# ====================
# Mode Command Tests
# ====================

@test "command supports 'check' mode" {
    run cat "$(get_command_file)"
    [[ "$output" == *"check"* ]]
}

@test "command supports 'confirm' mode" {
    run cat "$(get_command_file)"
    [[ "$output" == *"confirm"* ]]
}

@test "command supports 'auto' mode" {
    run cat "$(get_command_file)"
    [[ "$output" == *"auto"* ]]
}

@test "command supports 'silent' mode" {
    run cat "$(get_command_file)"
    [[ "$output" == *"silent"* ]]
}

# ====================
# Status Command Tests
# ====================

@test "command supports 'status' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"status"* ]]
}

# ====================
# Help Command Tests
# ====================

@test "command supports 'help' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"help"* ]]
}

# ====================
# Update Command Tests
# ====================

@test "command supports 'update' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"update"* ]]
}

@test "update command includes install script URL" {
    run cat "$(get_command_file)"
    [[ "$output" == *"install.sh"* ]]
}

# ====================
# Model Command Tests
# ====================

@test "command supports 'model' argument" {
    run cat "$(get_command_file)"
    [[ "$output" == *"model"* ]]
}

@test "model command recommends fast models" {
    run cat "$(get_command_file)"
    [[ "$output" == *"flash"* ]] || [[ "$output" == *"haiku"* ]] || [[ "$output" == *"mini"* ]]
}
