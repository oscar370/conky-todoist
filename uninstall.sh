#!/bin/bash

# Remove config
rm -rf "$HOME/.config/conky/todoist-conky"

# Remove autostart
rm -f "$HOME/.config/autostart/conky-todoist.desktop"

# Kill running instance
killall conky 2>/dev/null

echo "Todoist Conky completely removed!"