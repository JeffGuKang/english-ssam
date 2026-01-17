#!/usr/bin/env bash
# Test helper for command tests

# Get project root
get_project_root() {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
}

# Get command file path
get_command_file() {
    echo "$(get_project_root)/command/english-ssam.md"
}

# Get skill file path
get_skill_file() {
    echo "$(get_project_root)/plugin/english-ssam/skill.md"
}

# Get plugin file path
get_plugin_file() {
    echo "$(get_project_root)/plugin/english-ssam/plugin.md"
}

# Assert file contains text
assert_file_contains() {
    local file="$1"
    local content="$2"
    if ! grep -q "$content" "$file" 2>/dev/null; then
        echo "FAIL: Expected file '$file' to contain: $content"
        return 1
    fi
    return 0
}

# Assert file does not contain text
assert_file_not_contains() {
    local file="$1"
    local content="$2"
    if grep -q "$content" "$file" 2>/dev/null; then
        echo "FAIL: Expected file '$file' NOT to contain: $content"
        return 1
    fi
    return 0
}

# Count occurrences of pattern in file
count_occurrences() {
    local file="$1"
    local pattern="$2"
    grep -c "$pattern" "$file" 2>/dev/null || echo "0"
}
