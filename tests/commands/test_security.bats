#!/usr/bin/env bats
# Security tests for English Ssam

load 'test_helper'

# ====================
# No Sensitive Data Tests
# ====================

@test "command file has no API keys" {
    run cat "$(get_command_file)"
    [[ "$output" != *"sk-"* ]]
    [[ "$output" != *"api_key"* ]]
    [[ "$output" != *"apiKey"* ]]
}

@test "skill file has no API keys" {
    run cat "$(get_skill_file)"
    [[ "$output" != *"sk-"* ]]
    [[ "$output" != *"api_key"* ]]
    [[ "$output" != *"apiKey"* ]]
}

@test "plugin file has no API keys" {
    run cat "$(get_plugin_file)"
    [[ "$output" != *"sk-"* ]]
    [[ "$output" != *"api_key"* ]]
    [[ "$output" != *"apiKey"* ]]
}

@test "command file has no passwords" {
    run cat "$(get_command_file)"
    [[ "$output" != *"password"* ]]
    [[ "$output" != *"secret"* ]]
    [[ "$output" != *"token"* ]]
}

@test "skill file has no passwords" {
    run cat "$(get_skill_file)"
    [[ "$output" != *"password"* ]]
    [[ "$output" != *"secret"* ]]
    [[ "$output" != *"token"* ]]
}

@test "plugin file has no passwords" {
    run cat "$(get_plugin_file)"
    [[ "$output" != *"password"* ]]
    [[ "$output" != *"secret"* ]]
    [[ "$output" != *"token"* ]]
}

# ====================
# No Dangerous Commands Tests
# ====================

@test "command file has no rm -rf" {
    run cat "$(get_command_file)"
    [[ "$output" != *"rm -rf /"* ]]
    [[ "$output" != *"rm -rf ~"* ]]
}

@test "skill file has no rm -rf" {
    run cat "$(get_skill_file)"
    [[ "$output" != *"rm -rf /"* ]]
    [[ "$output" != *"rm -rf ~"* ]]
}

@test "command file has no sudo commands" {
    run cat "$(get_command_file)"
    [[ "$output" != *"sudo"* ]]
}

@test "skill file has no sudo commands" {
    run cat "$(get_skill_file)"
    [[ "$output" != *"sudo"* ]]
}

@test "command file has no eval commands" {
    run cat "$(get_command_file)"
    [[ "$output" != *"eval("* ]]
    [[ "$output" != *"eval "* ]]
}

@test "skill file has no eval commands" {
    run cat "$(get_skill_file)"
    [[ "$output" != *"eval("* ]]
    [[ "$output" != *"eval "* ]]
}

# ====================
# URL Security Tests
# ====================

@test "command file only uses https URLs" {
    run bash -c "grep -o 'http://[^ ]*' '$(get_command_file)' | wc -l"
    [ "$output" -eq 0 ] || [ "${output//[[:space:]]/}" = "0" ]
}

@test "skill file only uses https URLs" {
    run bash -c "grep -o 'http://[^ ]*' '$(get_skill_file)' | wc -l"
    [ "$output" -eq 0 ] || [ "${output//[[:space:]]/}" = "0" ]
}

@test "plugin file only uses https URLs" {
    run bash -c "grep -o 'http://[^ ]*' '$(get_plugin_file)' | wc -l"
    [ "$output" -eq 0 ] || [ "${output//[[:space:]]/}" = "0" ]
}

@test "update command uses official GitHub URL" {
    run cat "$(get_command_file)"
    [[ "$output" == *"github.com/JeffGuKang/english-ssam"* ]]
}

# ====================
# Install Script Security Tests
# ====================

@test "install script exists" {
    [ -f "$(get_project_root)/scripts/install.sh" ]
}

@test "install script has no hardcoded credentials" {
    run cat "$(get_project_root)/scripts/install.sh"
    [[ "$output" != *"sk-"* ]]
    [[ "$output" != *"password="* ]]
    [[ "$output" != *"secret="* ]]
}

@test "install script uses official GitHub raw URL" {
    run cat "$(get_project_root)/scripts/install.sh"
    [[ "$output" == *"raw.githubusercontent.com/JeffGuKang/english-ssam"* ]]
}

@test "install script has no dangerous rm commands on system dirs" {
    run cat "$(get_project_root)/scripts/install.sh"
    [[ "$output" != *"rm -rf /"* ]]
    [[ "$output" != *"rm -rf /usr"* ]]
    [[ "$output" != *"rm -rf /etc"* ]]
    [[ "$output" != *"rm -rf /var"* ]]
}

# ====================
# File Permission Tests
# ====================

@test "install script is executable" {
    [ -x "$(get_project_root)/scripts/install.sh" ]
}

@test "plugin files are not executable" {
    [ ! -x "$(get_plugin_file)" ]
    [ ! -x "$(get_skill_file)" ]
}

@test "command file is not executable" {
    [ ! -x "$(get_command_file)" ]
}
