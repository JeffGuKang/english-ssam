#!/bin/bash
set -e

VERSION="1.7.0"
REPO_URL="https://raw.githubusercontent.com/JeffGuKang/english-ssam/main"
VERSION_CHECK_FILE="$HOME/.english-ssam-last-check"
CHECK_INTERVAL_DAYS=7

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_banner() {
    echo -e "${BLUE}"
    echo "  _____ _   _  ____ _     ___ ____  _   _   ____  ____    _    __  __ "
    echo " | ____| \ | |/ ___| |   |_ _/ ___|| | | | / ___// ___|| / \  |  \/  |"
    echo " |  _| |  \| | |  _| |    | |\___ \| |_| | \___ \\___ \ / _ \ | |\/| |"
    echo " | |___| |\  | |_| | |___ | | ___) |  _  |  ___) |___) / ___ \| |  | |"
    echo " |_____|_| \_|\____|_____|___|____/|_| |_| |____/|____/_/   \_\_|  |_|"
    echo -e "${NC}"
    echo -e "${GREEN}English Ssam (쌤) for OpenCode${NC}"
    echo ""
}

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --global          Install globally (default)"
    echo "  --update          Update to the latest version"
    echo "  --uninstall       Remove installation completely"
    echo "  --enable          Enable English Ssam"
    echo "  --disable         Disable English Ssam temporarily"
    echo "  --status          Check installation status"
    echo "  --help            Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --global"
    echo ""
    echo "One-liner installation:"
    echo "  curl -fsSL $REPO_URL/scripts/install.sh | bash -s -- --global"
}

# Compare semantic versions: returns 0 if v1 < v2, 1 otherwise
version_lt() {
    local v1="$1"
    local v2="$2"
    v1="${v1#v}"
    v2="${v2#v}"
    local IFS='.'
    read -ra V1_PARTS <<< "$v1"
    read -ra V2_PARTS <<< "$v2"
    for i in 0 1 2; do
        local p1="${V1_PARTS[$i]:-0}"
        local p2="${V2_PARTS[$i]:-0}"
        if (( p1 < p2 )); then return 0; elif (( p1 > p2 )); then return 1; fi
    done
    return 1
}

should_check_version() {
    if [ ! -f "$VERSION_CHECK_FILE" ]; then return 0; fi
    local last_check=$(cat "$VERSION_CHECK_FILE" 2>/dev/null || echo "0")
    local now=$(date +%s)
    local diff=$(( (now - last_check) / 86400 ))
    if [ "$diff" -ge "$CHECK_INTERVAL_DAYS" ]; then return 0; fi
    return 1
}

save_check_timestamp() {
    date +%s > "$VERSION_CHECK_FILE"
}

check_for_updates() {
    local remote_version=""
    if command -v curl &> /dev/null; then
        remote_version=$(curl -fsSL "$REPO_URL/VERSION" 2>/dev/null | tr -d '[:space:]')
    elif command -v wget &> /dev/null; then
        remote_version=$(wget -qO- "$REPO_URL/VERSION" 2>/dev/null | tr -d '[:space:]')
    fi
    if [ -z "$remote_version" ]; then return; fi
    save_check_timestamp
    if version_lt "$VERSION" "$remote_version"; then
        echo -e "${CYAN}┌─────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${CYAN}│${NC}  ${YELLOW}📦 Update Available!${NC}                                       ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Current: ${RED}$VERSION${NC} | Latest: ${GREEN}$remote_version${NC}                     ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Run with ${YELLOW}--update${NC} or \"/english-ssam update\"                ${CYAN}│${NC}"
        echo -e "${CYAN}└─────────────────────────────────────────────────────────────┘${NC}"
    fi
}

maybe_check_for_updates() {
    if should_check_version; then check_for_updates; fi
}

get_plugin_dir() {
    echo "$HOME/.config/opencode/plugin/english-ssam"
}

get_command_file() {
    echo "$HOME/.config/opencode/command/english-ssam.md"
}

check_status() {
    local plugin_dir=$(get_plugin_dir)
    local cmd_file=$(get_command_file)
    local disabled_dir="${plugin_dir}.disabled"
    
    echo -e "${BLUE}English Ssam Status:${NC}"
    if [ -d "$plugin_dir" ]; then
        echo -e "  Status: ${GREEN}ENABLED${NC} ✓"
    elif [ -d "$disabled_dir" ]; then
        echo -e "  Status: ${YELLOW}DISABLED${NC}"
    else
        echo -e "  Status: ${RED}NOT INSTALLED${NC}"
    fi
}

install_opencode() {
    local action="$1"
    local plugin_dir=$(get_plugin_dir)
    local command_dir="$HOME/.config/opencode/command"
    local plugin_dest="$plugin_dir/plugin.md"
    local skill_dest="$plugin_dir/skill.md"
    local cmd_dest=$(get_command_file)
    
    local config_file=""
    if [ -f "$HOME/.config/opencode/opencode.jsonc" ]; then
        config_file="$HOME/.config/opencode/opencode.jsonc"
    elif [ -f "$HOME/.config/opencode/opencode.json" ]; then
        config_file="$HOME/.config/opencode/opencode.json"
    fi
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling...${NC}"
        rm -rf "$plugin_dir" "${plugin_dir}.disabled"
        rm -f "$cmd_dest"
        if [ -n "$config_file" ] && command -v python3 &> /dev/null; then
            python3 -c "
import json, re, sys
try:
    with open('$config_file', 'r') as f: content = f.read()
    content = re.sub(r'//.*$', '', content, flags=re.MULTILINE)
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    config = json.loads(content)
    if 'instructions' in config:
        config['instructions'] = [i for i in config['instructions'] if i != '$skill_dest']
    with open('$config_file', 'w') as f: json.dump(config, f, indent=2)
except: pass
"
        fi
        echo -e "${GREEN}Uninstalled!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for OpenCode...${NC}"
    mkdir -p "$plugin_dir" "$command_dir"
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$REPO_URL/plugin/english-ssam/plugin.md" -o "$plugin_dest"
        curl -fsSL "$REPO_URL/plugin/english-ssam/skill.md" -o "$skill_dest"
        curl -fsSL "$REPO_URL/command/english-ssam.md" -o "$cmd_dest"
    else
        wget -q "$REPO_URL/plugin/english-ssam/plugin.md" -O "$plugin_dest"
        wget -q "$REPO_URL/plugin/english-ssam/skill.md" -O "$skill_dest"
        wget -q "$REPO_URL/command/english-ssam.md" -O "$cmd_dest"
    fi
    
    if [ -n "$config_file" ] && command -v python3 &> /dev/null; then
        python3 -c "
import json, re, sys
try:
    with open('$config_file', 'r') as f: content = f.read()
    content = re.sub(r'//.*$', '', content, flags=re.MULTILINE)
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    config = json.loads(content)
    if 'instructions' not in config: config['instructions'] = []
    if '$skill_dest' not in config['instructions']:
        config['instructions'].append('$skill_dest')
        with open('$config_file', 'w') as f: json.dump(config, f, indent=2)
except: pass
"
    fi
    
    if [ "$action" != "update" ]; then
        echo ""
        echo -e "${CYAN}Choose a fast model for /english-ssam command:${NC}"
        echo -e "  ${YELLOW}1${NC}) google/antigravity-gemini-3-flash (Zen - recommended)"
        echo -e "  ${YELLOW}2${NC}) google/gemini-2.0-flash-exp"
        echo -e "  ${YELLOW}3${NC}) anthropic/claude-3-haiku-20240307"
        echo -e "  ${YELLOW}4${NC}) openai/gpt-4o-mini"
        echo -e "  ${YELLOW}5${NC}) Skip"
        echo ""
        read -p "Enter choice [1-5]: " model_choice
        case $model_choice in
            1) selected_model="google/antigravity-gemini-3-flash" ;;
            2) selected_model="google/gemini-2.0-flash-exp" ;;
            3) selected_model="anthropic/claude-3-haiku-20240307" ;;
            4) selected_model="openai/gpt-4o-mini" ;;
            *) selected_model="" ;;
        esac
        if [ -n "$selected_model" ] && command -v sed &> /dev/null; then
            sed -i.bak "s/^description:/model: $selected_model\ndescription:/" "$cmd_dest"
            rm -f "${cmd_dest}.bak"
        fi
    fi
    echo -e "${GREEN}Success! Use /english-ssam to toggle.${NC}"
}

ACTION="install"
for arg in "$@"; do
    case $arg in
        --update) ACTION="update" ;;
        --uninstall) ACTION="uninstall" ;;
        --enable) ACTION="enable" ;;
        --disable) ACTION="disable" ;;
        --status) ACTION="status" ;;
        --global|--local) ;;
        --help) print_banner; print_help; exit 0 ;;
        *) echo -e "${RED}Unknown option: $arg${NC}"; print_help; exit 1 ;;
    esac
done

print_banner
case $ACTION in
    status) check_status; maybe_check_for_updates; exit 0 ;;
    disable)
        plugin_dir=$(get_plugin_dir)
        if [ -d "$plugin_dir" ]; then mv "$plugin_dir" "${plugin_dir}.disabled"; echo "Disabled."; fi
        exit 0 ;;
    enable)
        plugin_dir=$(get_plugin_dir)
        if [ -d "${plugin_dir}.disabled" ]; then mv "${plugin_dir}.disabled" "$plugin_dir"; echo "Enabled."; fi
        exit 0 ;;
    *) install_opencode "$ACTION" ;;
esac
maybe_check_for_updates
