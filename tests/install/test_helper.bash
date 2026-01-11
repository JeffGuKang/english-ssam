#!/usr/bin/env bash

setup_test_env() {
    export TEST_DIR=$(mktemp -d)
    export TEST_HOME="$TEST_DIR/home"
    export TEST_PROJECT="$TEST_DIR/project"
    
    mkdir -p "$TEST_HOME" "$TEST_PROJECT"
    
    export ORIGINAL_HOME="$HOME"
    export HOME="$TEST_HOME"
    
    cd "$TEST_PROJECT"
}

teardown_test_env() {
    export HOME="$ORIGINAL_HOME"
    
    if [ -n "$TEST_DIR" ] && [ -d "$TEST_DIR" ]; then
        rm -rf "$TEST_DIR"
    fi
}

get_install_script() {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/scripts/install.sh"
}

run_install() {
    local script=$(get_install_script)
    bash "$script" "$@"
}

assert_file_exists() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "FAIL: Expected file to exist: $file"
        return 1
    fi
    return 0
}

assert_file_not_exists() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "FAIL: Expected file to NOT exist: $file"
        return 1
    fi
    return 0
}

assert_dir_exists() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "FAIL: Expected directory to exist: $dir"
        return 1
    fi
    return 0
}

assert_file_contains() {
    local file="$1"
    local content="$2"
    if ! grep -q "$content" "$file" 2>/dev/null; then
        echo "FAIL: Expected file '$file' to contain: $content"
        return 1
    fi
    return 0
}

assert_exit_code() {
    local expected="$1"
    local actual="$2"
    if [ "$actual" -ne "$expected" ]; then
        echo "FAIL: Expected exit code $expected, got $actual"
        return 1
    fi
    return 0
}

assert_output_contains() {
    local output="$1"
    local expected="$2"
    if [[ "$output" != *"$expected"* ]]; then
        echo "FAIL: Expected output to contain: $expected"
        echo "Got: $output"
        return 1
    fi
    return 0
}

setup_mock_download() {
    local content="$1"
    
    mkdir -p "$TEST_DIR/bin"
    
    cat > "$TEST_DIR/bin/curl" << MOCK_EOF
#!/bin/bash
output_file=""
for arg in "\$@"; do
    if [[ "\$prev_arg" == "-o" ]]; then
        output_file="\$arg"
    fi
    prev_arg="\$arg"
done

if [[ -n "\$output_file" ]]; then
    echo "$content" > "\$output_file"
else
    echo "$content"
fi
MOCK_EOF
    chmod +x "$TEST_DIR/bin/curl"
    
    export PATH="$TEST_DIR/bin:$PATH"
}
