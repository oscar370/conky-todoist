#!/bin/bash

# --- Configuration ---
CONFIG_DIR="$HOME/.config/conky/todoist-conky"
SCRIPT_DIR="$CONFIG_DIR/scripts"

# --- Check Dependencies ---
check_dependencies() {
    dependencies=("conky" "python3" "pip3")
    missing=()

    for dep in "${dependencies[@]}"; do
        if ! command -v $dep &> /dev/null; then
            missing+=("$dep")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo "Missing dependencies:"
        printf " - %s\n" "${missing[@]}"
        echo "Install them first."
        exit 1
    fi

    if ! python3 -c "import requests" &> /dev/null; then
        echo "Installing Python 'requests' library..."
        pip3 install requests
    fi
}

# --- Main Installation ---
install() {
    check_dependencies

    mkdir -p "$SCRIPT_DIR"
    
    echo "Downloading files..."
    curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/conky.conf -o "$CONFIG_DIR/conky.conf"
    curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/todoist_conky.py -o "$SCRIPT_DIR/todoist_conky.py"
    curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/format_tasks.sh -o "$SCRIPT_DIR/format_tasks.sh"

    chmod +x "$SCRIPT_DIR"/*.sh
    chmod +x "$SCRIPT_DIR/todoist_conky.py"

    echo "Success! Edit API token in:"
    echo "  $SCRIPT_DIR/todoist_conky.py"
}

install