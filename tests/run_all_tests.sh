#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           English Ssam Test Suite                            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

check_bats() {
    if ! command -v bats &> /dev/null; then
        echo -e "${YELLOW}BATS not found. Installing...${NC}"
        
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install bats-core
            else
                echo -e "${RED}Please install Homebrew or BATS manually${NC}"
                exit 1
            fi
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y bats
            elif command -v yum &> /dev/null; then
                sudo yum install -y bats
            else
                echo -e "${YELLOW}Installing BATS from source...${NC}"
                git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
                cd /tmp/bats-core && sudo ./install.sh /usr/local
                cd "$PROJECT_ROOT"
            fi
        fi
    fi
    echo -e "${GREEN}BATS is available${NC}"
}

run_install_tests() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Running Install Script Tests${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    chmod +x "$PROJECT_ROOT/scripts/install.sh"
    
    bats "$SCRIPT_DIR/install/"
}

show_behavior_tests() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Behavior Test Cases${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}Behavior tests are manual verification tests.${NC}"
    echo "Test case files:"
    echo "  - tests/behavior/test_toggle.md"
    echo "  - tests/behavior/test_corrections.md"
    echo "  - tests/behavior/test_patterns.md"
    echo ""
    echo "To view test cases:"
    echo "  cat tests/behavior/test_toggle.md"
    echo ""
}

main() {
    check_bats
    run_install_tests
    show_behavior_tests
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║           All automated tests completed!                     ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
}

main "$@"
