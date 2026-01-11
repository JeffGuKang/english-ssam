#!/bin/bash
set -e

VERSION="1.2.0"
REPO_URL="https://raw.githubusercontent.com/code-yeongyu/english-ssam/main"
RULE_FILE="ENGLISH_SSAM.md"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_banner() {
    echo -e "${BLUE}"
    echo "  _____ _   _  ____ _     ___ ____  _   _   ____  ____    _    __  __ "
    echo " | ____| \ | |/ ___| |   |_ _/ ___|| | | | / ___||  _ \  / \  |  \/  |"
    echo " |  _| |  \| | |  _| |    | |\___ \| |_| | \___ \| |_) |/ _ \ | |\/| |"
    echo " | |___| |\  | |_| | |___ | | ___) |  _  |  ___) |  __// ___ \| |  | |"
    echo " |_____|_| \_|\____|_____|___|____/|_| |_| |____/|_|  /_/   \_\_|  |_|"
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

get_file_path() {
    local tool="$1"
    local mode="$2"
    
    case $tool in
        opencode)
            echo "$HOME/.config/opencode/instructions/english-ssam.md"
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
    
    local dest="$HOME/.config/opencode/instructions/english-ssam.md"
    local dir=$(dirname "$dest")
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from OpenCode...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for OpenCode (global)...${NC}"
    mkdir -p "$dir"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
}

install_cursor() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Cursor only supports local (project) installation${NC}"
    fi
    
    local dest=".cursorrules"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Cursor...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for Cursor (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
}

install_claude_code() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Claude Code only supports local (project) installation${NC}"
    fi
    
    local dest="CLAUDE.md"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Claude Code...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for Claude Code (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
}

install_copilot() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}GitHub Copilot only supports local (project) installation${NC}"
    fi
    
    local dest=".github/copilot-instructions.md"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from GitHub Copilot...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for GitHub Copilot (local)...${NC}"
    mkdir -p ".github"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
}

install_windsurf() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Windsurf only supports local (project) installation${NC}"
    fi
    
    local dest=".windsurfrules"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Windsurf...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for Windsurf (local)...${NC}"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
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
    
    echo -e "${BLUE}Installing English Ssam for Aider ($mode)...${NC}"
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
    
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "Files: ${YELLOW}$config_dest${NC}, ${YELLOW}$prompt_dest${NC}"
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
    
    echo -e "${BLUE}Installing English Ssam for Continue (global)...${NC}"
    mkdir -p "$config_dir"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    
    echo -e "${GREEN}Installed: $dest${NC}"
    echo ""
    echo -e "${YELLOW}To complete setup, add to your $config_dir/config.json:${NC}"
    echo '  "customInstructions": "Follow instructions in ~/.continue/english-ssam.md"'
}

install_zed() {
    local mode="$1"
    local action="$2"
    
    if [ "$mode" != "local" ]; then
        echo -e "${YELLOW}Zed only supports local (project) installation${NC}"
    fi
    
    local dest=".zed/prompt.md"
    
    if [ "$action" = "uninstall" ]; then
        echo -e "${YELLOW}Uninstalling English Ssam from Zed...${NC}"
        rm -f "$dest" "${dest}.disabled"
        echo -e "${GREEN}Uninstalled successfully!${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing English Ssam for Zed (local)...${NC}"
    mkdir -p ".zed"
    download_rule "$dest"
    rm -f "${dest}.disabled"
    echo -e "${GREEN}Installed successfully!${NC}"
    echo -e "File: ${YELLOW}$dest${NC}"
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
    exit 0
fi

if [ "$ACTION" = "disable" ]; then
    disable_tool "$TOOL" "$MODE"
    echo ""
    echo -e "${GREEN}English Ssam is now disabled.${NC}"
    exit 0
fi

if [ "$ACTION" = "enable" ]; then
    enable_tool "$TOOL" "$MODE"
    echo ""
    echo -e "${GREEN}English Ssam is now enabled!${NC}"
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

if [ "$ACTION" = "install" ]; then
    echo ""
    echo -e "${GREEN}English Ssam is ready to help you improve your English!${NC}"
    echo -e "Use ${YELLOW}--disable${NC} to temporarily turn off, ${YELLOW}--enable${NC} to restore."
fi
