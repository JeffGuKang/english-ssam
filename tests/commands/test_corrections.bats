#!/usr/bin/env bats
# Correction category tests for English Ssam skill file

load 'test_helper'

# ====================
# Article Correction Tests
# ====================

@test "skill corrects article usage" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Articles"* ]] || [[ "$output" == *"a/an/the"* ]]
}

@test "skill shows missing article example" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"I have"* ]] && [[ "$output" == *"computer"* ]]
}

@test "skill shows 'the' article usage" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"The"* ]] && [[ "$output" == *"sun"* ]]
}

# ====================
# Preposition Correction Tests
# ====================

@test "skill corrects preposition usage" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Prepositions"* ]] || [[ "$output" == *"in/on/at"* ]]
}

@test "skill shows good at example" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"good"* ]] && [[ "$output" == *"coding"* ]]
}

# ====================
# Plural Correction Tests
# ====================

@test "skill corrects plural forms" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Plurals"* ]] || [[ "$output" == *"Plural"* ]]
}

@test "skill shows missing plural example" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"many friend"* ]]
}

# ====================
# Word Order Correction Tests
# ====================

@test "skill corrects word order" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Word Order"* ]]
}

@test "skill explains SVO order" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"SVO"* ]] || [[ "$output" == *"Subject-Verb-Object"* ]]
}

# ====================
# Verb Tense Correction Tests
# ====================

@test "skill corrects verb tenses" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Verb Tenses"* ]] || [[ "$output" == *"tense"* ]]
}

# ====================
# Subject-Verb Agreement Tests
# ====================

@test "skill corrects subject-verb agreement" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Subject-Verb Agreement"* ]] || [[ "$output" == *"Agreement"* ]]
}

# ====================
# Natural Expression Tests
# ====================

@test "skill improves natural expressions" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Natural"* ]] || [[ "$output" == *"native"* ]]
}

# ====================
# Korean Speaker Focus Tests
# ====================

@test "skill focuses on Korean speakers" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Korean"* ]]
}

@test "skill mentions common Korean speaker issues" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Korean"* ]] && [[ "$output" == *"common"* ]]
}

# ====================
# Correction Table Format Tests
# ====================

@test "skill uses table format for corrections" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"|"* ]]
}

@test "skill table includes category column" {
    run cat "$(get_skill_file)"
    [[ "$output" == *"Category"* ]] || [[ "$output" == *"Original"* ]]
}
