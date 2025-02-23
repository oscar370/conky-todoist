#!/bin/bash

trap '' PIPE

while IFS= read -r line; do
    case "$line" in
        "EMPTY")
            printf '${color #a6e3a1}¡No hay tareas!\n'
            ;;
        ERROR::*)
            error_msg="${line#ERROR::}"
            printf '${color #f38ba8}Error: %s\n' "$error_msg"
            ;;
        *"||"*)
            date_part="${line%%||*}"
            task_part="${line#*||}"
            if [ -n "$date_part" ]; then
                printf '${color #cba6f7}[%s] ${color #cdd6f4}%s\n' "$date_part" "$task_part"
            else
                printf '${color #cdd6f4}→ %s\n' "$task_part"
            fi
            ;;
        *)
            printf '${color #cdd6f4}→ %s\n' "$line"
            ;;
    esac
done