#!/usr/bin/env bats
# Feature tests for English Ssam plugin

load 'test_helper'

# ====================
# Plugin File Structure Tests
# ====================

@test "plugin file exists" {
    [ -f "$(get_plugin_file)" ]
}

@test "plugin has name in frontmatter" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"name: english-ssam"* ]]
}

@test "plugin has version in frontmatter" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"version:"* ]]
}

@test "plugin has author in frontmatter" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"author:"* ]]
}

@test "plugin has repository in frontmatter" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"repository:"* ]]
    [[ "$output" == *"github.com"* ]]
}

# ====================
# Installation Documentation Tests
# ====================

@test "plugin documents installation" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"Installation"* ]] || [[ "$output" == *"install"* ]]
}

@test "plugin includes install command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"curl"* ]] || [[ "$output" == *"install.sh"* ]]
}

# ====================
# File Structure Documentation Tests
# ====================

@test "plugin documents file structure" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"File Structure"* ]] || [[ "$output" == *"structure"* ]]
}

@test "plugin mentions command file location" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"command/english-ssam.md"* ]]
}

@test "plugin mentions skill file location" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"plugin/english-ssam/skill.md"* ]]
}

# ====================
# Command Documentation Tests
# ====================

@test "plugin documents all commands" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"Commands"* ]]
}

@test "plugin lists toggle command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"/english-ssam"* ]] && [[ "$output" == *"Toggle"* ]]
}

@test "plugin lists check mode command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"check"* ]] && [[ "$output" == *"Check Mode"* ]]
}

@test "plugin lists confirm mode command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"confirm"* ]] && [[ "$output" == *"Confirm Mode"* ]]
}

@test "plugin lists auto mode command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"auto"* ]] && [[ "$output" == *"Auto Mode"* ]]
}

@test "plugin lists silent mode command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"silent"* ]] && [[ "$output" == *"Silent Mode"* ]]
}

@test "plugin lists status command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"status"* ]]
}

@test "plugin lists help command" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"help"* ]]
}

# ====================
# Teaching Style Tests
# ====================

@test "skill defines teaching style" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Teaching Style"* ]] || [[ "$output" == *"style"* ]]
}

@test "skill is encouraging" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Encouraging"* ]] || [[ "$output" == *"encourage"* ]]
}

@test "skill is practical" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Practical"* ]] || [[ "$output" == *"practical"* ]]
}

@test "skill is patient" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Patient"* ]] || [[ "$output" == *"patient"* ]]
}

# ====================
# Periodic Tips Feature Tests
# ====================

@test "skill provides periodic tips" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Tip"* ]] || [[ "$output" == *"tip"* ]]
}

@test "tips include topic" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Topic"* ]]
}

@test "tips include example" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Example"* ]]
}

# ====================
# License Tests
# ====================

@test "plugin has license" {
    run cat "$(get_plugin_file)"
    [[ "$output" == *"License"* ]] || [[ "$output" == *"MIT"* ]]
}
