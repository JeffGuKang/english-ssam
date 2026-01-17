#!/usr/bin/env bats
# Mode behavior tests for English Ssam skill file

load 'test_helper'

# ====================
# Skill File Structure Tests
# ====================

@test "skill file exists" {
    [ -f "$(get_skill_file)" ]
}

@test "skill file documents default state as ON" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Default state: ON"* ]] || [[ "$output" == *"default"* ]]
}

# ====================
# Check Mode Tests
# ====================

@test "skill documents check mode" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Check Mode"* ]]
}

@test "check mode shows corrections then executes" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Show corrections"* ]] || [[ "$output" == *"execute immediately"* ]]
}

@test "check mode shows English Check header" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"English Check"* ]]
}

@test "check mode shows Your prompt format" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Your prompt"* ]]
}

@test "check mode shows Suggested revision format" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Suggested"* ]]
}

# ====================
# Confirm Mode Tests
# ====================

@test "skill documents confirm mode" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Confirm Mode"* ]]
}

@test "confirm mode waits for approval" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"wait"* ]] || [[ "$output" == *"approval"* ]] || [[ "$output" == *"Waiting"* ]]
}

@test "confirm mode shows Y/N/E options" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Y"* ]] && [[ "$output" == *"N"* ]] && [[ "$output" == *"E"* ]]
}

@test "confirm mode accepts Korean responses" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"예"* ]] || [[ "$output" == *"아니"* ]]
}

# ====================
# Auto Mode Tests
# ====================

@test "skill documents auto mode" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Auto Mode"* ]]
}

@test "auto mode auto-proceeds" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"auto-proceed"* ]] || [[ "$output" == *"auto-proceeding"* ]]
}

# ====================
# Silent Mode Tests
# ====================

@test "skill documents silent mode" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Silent Mode"* ]]
}

@test "silent mode applies corrections internally" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"internally"* ]] || [[ "$output" == *"without displaying"* ]]
}

# ====================
# Mode Output Format Tests
# ====================

@test "modes use emoji header" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"🎓"* ]]
}

@test "modes show Original field" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Original"* ]]
}

@test "modes show Corrected field" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Corrected"* ]]
}

@test "modes show Why explanation" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Why"* ]]
}

# ====================
# Perfect English Behavior Tests
# ====================

@test "skill handles perfect English" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Perfect English"* ]] || [[ "$output" == *"English is Good"* ]]
}

@test "perfect English proceeds immediately" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Proceeding"* ]] || [[ "$output" == *"proceed immediately"* ]]
}
