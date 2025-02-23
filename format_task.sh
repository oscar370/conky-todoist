#!/bin/bash

while IFS= read -r line; do
    case "$line" in
        "EMPTY") echo '${color3}No pending tasks' ;;
        ERROR::*) echo '${color4}Error: '"${line#ERROR::}" ;;
        *||*) 
            date="${line%||*}"
            task="${line#*||}"
            [ -n "$date" ] && echo '${color2}[$date] ${color1}$task' || echo '${color1}→ $task'
            ;;
        *) echo '${color1}→ $line' ;;
    esac
done