#!/bin/bash

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Paths ---
CONFIG_DIR="$HOME/.config/conky/todoist-conky"
SCRIPT_DIR="$CONFIG_DIR/scripts"
AUTOSTART_DIR="$HOME/.config/autostart"

# --- Dependencies Check ---
check_dependencies() {
    local missing=()
    local python_deps=("requests")

    # Binaries
    declare -A binaries=(
        ["conky"]="sudo apt install conky-all"
        ["python3"]="sudo apt install python3"
        ["curl"]="sudo apt install curl"
        ["pip3"]="sudo apt install python3-pip"
    )

    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    for cmd in "${!binaries[@]}"; do
        if ! command -v $cmd &>/dev/null; then
            echo -e "${RED}✗ Missing: $cmd${NC}"
            missing+=("${binaries[$cmd]}")
        else
            echo -e "${GREEN}✓ Found: $cmd${NC}"
        fi
    done

    # Python modules
    echo -e "\n${YELLOW}Checking Python modules...${NC}"
    for module in "${python_deps[@]}"; do
        if ! python3 -c "import $module" &>/dev/null; then
            echo -e "${RED}✗ Missing Python module: $module${NC}"
            missing+=("pip3 install $module")
        else
            echo -e "${GREEN}✓ Found: $module${NC}"
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "\n${RED}ERROR: Missing dependencies. Run these commands:${NC}"
        printf "%s\n" "${missing[@]}"
        exit 1
    fi
}

# --- Main Installation ---
install() {
    check_dependencies

    # Create directories
    mkdir -p "$SCRIPT_DIR" "$AUTOSTART_DIR"

    # Download files
    echo -e "\n${YELLOW}Downloading components...${NC}"
    curl -sL "https://raw.githubusercontent.com/tu_repo/conky-todoist/main/conky.conf" -o "$CONFIG_DIR/conky.conf"
    curl -sL "https://raw.githubusercontent.com/tu_repo/conky-todoist/main/todoist_conky.py" -o "$SCRIPT_DIR/todoist_conky.py"
    curl -sL "https://raw.githubusercontent.com/tu_repo/conky-todoist/main/format_tasks.sh" -o "$SCRIPT_DIR/format_tasks.sh"

    # Permissions
    chmod +x "$SCRIPT_DIR"/*.sh
    chmod +x "$SCRIPT_DIR/todoist_conky.py"

    # Autostart
    echo -e "\n${YELLOW}Configuring autostart...${NC}"
    cat > "$AUTOSTART_DIR/conky-todoist.desktop" <<EOL
[Desktop Entry]
Type=Application
Name=Todoist Conky
Exec=conky -c $CONFIG_DIR/concy.conf
Comment=Todoist tasks widget
X-GNOME-Autostart-enabled=true
EOL

    echo -e "\n${GREEN}Installation complete!${NC}"
    echo -e "Edit your API token in:"
    echo -e "  ${YELLOW}$SCRIPT_DIR/todoist_conky.py${NC}\n"
}

install