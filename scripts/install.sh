#!/bin/bash
set -e

VERSION="1.3.0"
REPO_URL="https://raw.githubusercontent.com/JeffGuKang/english-ssam/main"
RULE_FILE="ENGLISH_SSAM.md"
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
    echo -e "${GREEN}Your Friendly English Tutor for AI Coding Assistants${NC}"
    echo ""
}

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --tool=TOOL       AI tool to install for (required)"
    echo "                    Supported: opencode, cursor, claude-code, copilot, windsurf, aider, continue, zed"
    echo "  --global          Install globally (user-wide)"
    echo "  --local           Install locally (current project)"
    echo "  --update          Update to the latest version"
    echo "  --uninstall       Remove installation completely"
    echo "  --enable          Enable English Ssam (restore from disabled state)"
    echo "  --disable         Disable English Ssam temporarily (keeps backup)"
    echo "  --status          Check if English Ssam is installed and enabled"
    echo "  --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --tool=cursor --local"
    echo "  $0 --tool=opencode --global"
    echo "  $0 --tool=cursor --local --disable"
    echo "  $0 --tool=cursor --local --enable"
    echo "  $0 --tool=opencode --global --status"
    echo ""
    echo "One-liner installation:"
    echo "  curl -fsSL $REPO_URL/scripts/install.sh | bash -s -- --tool=cursor --local"
}

download_rule() {
    local dest="$1"
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$REPO_URL/$RULE_FILE" -o "$dest"
    elif command -v wget &> /dev/null; then
        wget -q "$REPO_URL/$RULE_FILE" -O "$dest"
    else
        echo -e "${RED}Error: curl or wget is required${NC}"
        exit 1
    fi
}

# Compare semantic versions: returns 0 if v1 < v2, 1 otherwise
version_lt() {
    local v1="$1"
    local v2="$2"
    
    # Remove 'v' prefix if present
    v1="${v1#v}"
    v2="${v2#v}"
    
    # Split into parts
    local IFS='.'
    read -ra V1_PARTS <<< "$v1"
    read -ra V2_PARTS <<< "$v2"
    
    for i in 0 1 2; do
        local p1="${V1_PARTS[$i]:-0}"
        local p2="${V2_PARTS[$i]:-0}"
        if (( p1 < p2 )); then
            return 0
        elif (( p1 > p2 )); then
            return 1
        fi
    done
    return 1  # Equal versions
}

# Check if we should perform a version check (based on time interval)
should_check_version() {
    if [ ! -f "$VERSION_CHECK_FILE" ]; then
        return 0  # Never checked before
    fi
    
    local last_check
    last_check=$(cat "$VERSION_CHECK_FILE" 2>/dev/null || echo "0")
    local now
    now=$(date +%s)
    local diff=$(( (now - last_check) / 86400 ))  # Days since last check
    
    if [ "$diff" -ge "$CHECK_INTERVAL_DAYS" ]; then
        return 0  # Time to check
    fi
    return 1  # Too soon
}

# Save current timestamp as last check time
save_check_timestamp() {
    date +%s > "$VERSION_CHECK_FILE"
}

# Fetch remote version and compare with local
check_for_updates() {
    local remote_version=""
    
    # Try to fetch remote VERSION file
    if command -v curl &> /dev/null; then
        remote_version=$(curl -fsSL "$REPO_URL/VERSION" 2>/dev/null | tr -d '[:space:]')
    elif command -v wget &> /dev/null; then
        remote_version=$(wget -qO- "$REPO_URL/VERSION" 2>/dev/null | tr -d '[:space:]')
    fi
    
    if [ -z "$remote_version" ]; then
        return  # Failed to fetch, skip silently
    fi
    
    # Save that we checked
    save_check_timestamp
    
    # Compare versions
    if version_lt "$VERSION" "$remote_version"; then
        echo ""
        echo -e "${CYAN}┌─────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${CYAN}│${NC}  ${YELLOW}📦 Update Available!${NC}                                       ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}                                                             ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Current version: ${RED}$VERSION${NC}                                    ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Latest version:  ${GREEN}$remote_version${NC}                                    ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}                                                             ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Run with ${YELLOW}--update${NC} to get the latest version              ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  Or tell your AI: ${YELLOW}\"update english-ssam\"${NC}                   ${CYAN}│${NC}"
        echo -e "${CYAN}└─────────────────────────────────────────────────────────────┘${NC}"
        echo ""
    fi
}

# Perform weekly version check (non-blocking, runs in background context)
maybe_check_for_updates() {
    if should_check_version; then
        check_for_updates
    fi
}

get_file_path() {
    local tool="$1"
    local mode="$2"
    
    case $tool in
        opencode)
            echo "$HOME/.config/opencode/skill/english-ssam.md"
            ;;
        cursor)
            echo ".cursorrules"
            ;;
        claude-code|claude)
            echo "CLAUDE.md"
            ;;
        copilot|github-copilot)
            echo ".github/copilot-instructions.md"
            ;;
        windsurf)
            echo ".windsurfrules"
            ;;
        aider)
            if [ "$mode" = "global" ]; then
                echo "$HOME/.aider-english-ssam.md"
            else
                echo ".aider-english-ssam.md"
            fi
            ;;
        continue)
            echo "$HOME/.continue/english-ssam.md"
            ;;
        zed)
            echo ".zed/prompt.md"
            ;;
    esac
}

check_status() {
    local tool="$1"
    local mode="$2"
    local file_path=$(get_file_path "$tool" "$mode")
    local disabled_path="${file_path}.disabled"
    
    echo -e "${BLUE}English Ssam Status for $tool:${NC}"
    echo ""
    
    if [ -f "$file_path" ]; then
        echo -e "  Status: ${GREEN}ENABLED${NC} ✓"
        echo -e "  File: $file_path"
    elif [ -f "$disabled_path" ]; then
        echo -e "  Status: ${YELLOW}DISABLED${NC} (backup exists)"
        echo -e "  Backup: $disabled_path"
        echo -e "  Use ${YELLOW}--enable${NC} to restore"
    else
        echo -e "  Status: ${RED}NOT INSTALLED${NC}"
        echo -e "  Use ${YELLOW}--tool=$tool --$mode${NC} to install"
    fi
}

disable_tool() {
    local tool="$1"
    local mode="$2"
    local file_path=$(get_file_path "$tool" "$mode")
    local disabled_path="${file_path}.disabled"
    
    if [ -f "$file_path" ]; then
        mv "$file_path" "$disabled_path"
        echo -e "${YELLOW}Disabled English Ssam for $tool${NC}"
        echo -e "Backup saved to: ${YELLOW}$disabled_path${NC}"
        echo -e "Use ${GREEN}--enable${NC} to restore"
    elif [ -f "$disabled_path" ]; then
        echo -e "${YELLOW}English Ssam is already disabled for $tool${NC}"
    else
        echo -e "${RED}English Ssam is not installed for $tool${NC}"
    fi
}

enable_tool() {
    local tool="$1"
    local mode="$2"
    local file_path=$(get_file_path "$tool" "$mode")
    local disabled_path="${file_path}.disabled"
    
    if [ -f "$disabled_path" ]; then
        mv "$disabled_path" "$file_path"
        echo -e "${GREEN}Enabled English Ssam for $tool${NC}"
        echo -e "File restored: ${YELLOW}$file_path${NC}"
    elif [ -f "$file_path" ]; then
        echo -e "${GREEN}English Ssam is already enabled for $tool${NC}"
    else
        echo -e "${RED}No backup found. Please install first.${NC}"
    fi
}

install_opencode() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "global" ]; then
        echo -e "${YELLOW}OpenCode only supports global installation${NC}"
    fi
    
    local skill_dest="$HOME/.config/opencode/skill/english-ssam.md"
    local cmd_dest="$HOME/.config/opencode/command/english-ssam.md"
    local skill_dir=$(dirname "$skill_dest")
    local cmd_dir=$(dirname "$cmd_dest")
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from OpenCode...${NC}"
        rm -f "$skill_dest" "${skill_dest}.disabled"
        rm -f "$cmd_dest" "${cmd_dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for OpenCode (global)...${NC}"
    mkdir -p "$skill_dir" "$cmd_dir"
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$REPO_URL/$RULE_FILE" -o "$skill_dest"
        curl -fsSL "$REPO_URL/command/english-ssam.md" -o "$cmd_dest"
    elif command -v wget &> /dev/null; then
        wget -q "$REPO_URL/$RULE_FILE" -O "$skill_dest"
        wget -q "$REPO_URL/command/english-ssam.md" -O "$cmd_dest"
    fi
    
    rm -f "${skill_dest}.disabled" "${cmd_dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "Skill: ${YELLOW}$skill_dest${NC}"
    echo -e "Command: ${YELLOW}$cmd_dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_cursor() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Cursor only supports local (project) installation${NC}"
    fi
    
    local dest=".cursorrules"
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Cursor...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for Cursor (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_claude_code() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Claude Code only supports local (project) installation${NC}"
    fi
    
    local dest="CLAUDE.md"
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Claude Code...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for Claude Code (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_copilot() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}GitHub Copilot only supports local (project) installation${NC}"
    fi
    
    local dest=".github/copilot-instructions.md"
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from GitHub Copilot...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for GitHub Copilot (local)...${NC}"
    mkdir -p ".github"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_windsurf() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Windsurf only supports local (project) installation${NC}"
    fi
    
    local dest=".windsurfrules"
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Windsurf...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for Windsurf (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_aider() {
    local mode="$1"
    local action="$2"
    
    local prompt_dest
    local config_dest
    
    if [ "$mode" = "global" ]; then
        prompt_dest="$HOME/.aider-english-ssam.md"
        config_dest="$HOME/.aider.conf.yml"
    else
        prompt_dest=".aider-english-ssam.md"
        config_dest=".aider.conf.yml"
    fi
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Aider...${NC}"
        rm -f "$prompt_dest" "${prompt_dest}.disabled"
        echo -e "${GREEN}Removed: $prompt_dest${NC}"
        echo -e "${YELLOW}Note: Please manually remove the 'read:' entry from $config_dest${NC}"
        return
    fi
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    echo -e "${BLUE}$verb English Ssam for Aider ($mode)...${NC}"
    download_rule "$prompt_dest"
    rm -f "${prompt_dest}.disabled"
    
    if [ -f "$config_dest" ]; then
        if ! grep -q "english-ssam" "$config_dest"; then
            echo "" >> "$config_dest"
            echo "read:" >> "$config_dest"
            echo "  - $prompt_dest" >> "$config_dest"
        fi
    else
        echo "read:" > "$config_dest"
        echo "  - $prompt_dest" >> "$config_dest"
    fi
    
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "Files: ${YELLOW}$config_dest${NC}, ${YELLOW}$prompt_dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_continue() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "global" ]; then
        echo -e "${YELLOW}Continue only supports global installation${NC}"
    fi
    
    local config_dir="$HOME/.continue"
    local dest="$config_dir/english-ssam.md"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Continue...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Removed: $dest${NC}"
        echo -e "${YELLOW}Note: Please manually update customInstructions in $config_dir/config.json${NC}"
        return
    fi
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    echo -e "${BLUE}$verb English Ssam for Continue (global)...${NC}"
    mkdir -p "$config_dir"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    
    echo -e "${GREEN}$done_verb: $dest${NC}"
    echo ""
    echo -e "${YELLOW}To complete setup, add to your $config_dir/config.json:${NC}"
    echo '  "customInstructions": "Follow instructions in ~/.continue/english-ssam.md"'
    echo ""
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

install_zed() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Zed only supports local (project) installation${NC}"
    fi
    
    local dest=".zed/prompt.md"
    
    local verb="Installing"
    local done_verb="Installed"
    if [ "$action" = "update" ]; then
        verb="Updating"
        done_verb="Updated"
    fi

    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Zed...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}$verb English Ssam for Zed (local)...${NC}"
    mkdir -p ".zed"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}$done_verb successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
    echo -e "Use ${YELLOW}/english-ssam${NC} to toggle on/off"
}

TOOL=""
MODE=""
ACTION="install"

for arg in "$@"; do
    case $arg in
        --tool=*)
            TOOL="${arg#*=}"
            ;;
        --global)
            MODE="global"
            ;;
        --local)
            MODE="local"
            ;;
        --update)
            ACTION="update"
            ;;
        --uninstall)
            ACTION="uninstall"
            ;;
        --enable)
            ACTION="enable"
            ;;
        --disable)
            ACTION="disable"
            ;;
        --status)
            ACTION="status"
            ;;
        --help)
            print_banner
            print_help
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $arg${NC}"
            print_help
            exit 1
            ;;
    esac
done

if [ -z "$TOOL" ]; then
    print_banner
    print_help
    exit 1
fi

if [ -z "$MODE" ]; then
    echo -e "${RED}Error: Please specify --global or --local${NC}"
    print_help
    exit 1
fi

print_banner

if [ "$ACTION" = "status" ]; then
    check_status "$TOOL" "$MODE"
    maybe_check_for_updates
    exit 0
fi

if [ "$ACTION" = "disable" ]; then
    disable_tool "$TOOL" "$MODE"
    echo ""
    echo -e "${GREEN}English Ssam is now disabled.${NC}"
    maybe_check_for_updates
    exit 0
fi

if [ "$ACTION" = "enable" ]; then
    enable_tool "$TOOL" "$MODE"
    echo ""
    echo -e "${GREEN}English Ssam is now enabled!${NC}"
    maybe_check_for_updates
    exit 0
fi

case $TOOL in
    opencode)
        install_opencode "$MODE" "$ACTION"
        ;;
    cursor)
        install_cursor "$MODE" "$ACTION"
        ;;
    claude-code|claude)
        install_claude_code "$MODE" "$ACTION"
        ;;
    copilot|github-copilot)
        install_copilot "$MODE" "$ACTION"
        ;;
    windsurf)
        install_windsurf "$MODE" "$ACTION"
        ;;
    aider)
        install_aider "$MODE" "$ACTION"
        ;;
    continue)
        install_continue "$MODE" "$ACTION"
        ;;
    zed)
        install_zed "$MODE" "$ACTION"
        ;;
    *)
        echo -e "${RED}Unknown tool: $TOOL${NC}"
        echo "Supported tools: opencode, cursor, claude-code, copilot, windsurf, aider, continue, zed"
        exit 1
        ;;
esac

if [ "$ACTION" = "update" ]; then
    save_check_timestamp
    echo ""
    echo -e "${GREEN}English Ssam has been updated to the latest version!${NC}"
elif [ "$ACTION" = "install" ]; then
    echo ""
    echo -e "${GREEN}English Ssam is ready to help you improve your English!${NC}"
    echo -e "Use ${YELLOW}--disable${NC} to temporarily turn off, ${YELLOW}--enable${NC} to restore."
    maybe_check_for_updates
fi
