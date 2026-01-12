#!/bin/bash

# Скрипт для підрахунку файлів - Версія 2.0

CONFIG_FILE="/etc/count_files.conf"
VERSION="2.0"

# Завантаження конфігурації за замовчуванням
VERBOSE=0
LOG_FILE=""

# Зчитування конфігураційного файлу, якщо він існує
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

show_help() {
    echo "Usage: count_files [DIRECTORY] [EXTENSION] [-v]"
    echo "Options:"
    echo "  DIRECTORY   Directory to scan (default from config or .)"
    echo "  EXTENSION   File extension to filter"
    echo "  -v          Verbose mode (detailed output)"
    echo "  -h          Show this help"
}

# Обробка аргументів
TARGET_DIR=""
EXTENSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=1
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$1"
            elif [ -z "$EXTENSION" ]; then
                EXTENSION="$1"
            fi
            shift
            ;;
    esac
done

# Використання значень з конфігу, якщо аргументи порожні
TARGET_DIR=${TARGET_DIR:-${DEFAULT_DIR:-"."}}
EXTENSION=${EXTENSION:-${DEFAULT_EXT}}

if [ ! -d "$TARGET_DIR" ]; then
    echo "Помилка: Директорія $TARGET_DIR не існує."
    exit 1
fi

[ "$VERBOSE" -eq 1 ] && echo "--- Версія $VERSION ---"
echo "Аналіз директорії: $TARGET_DIR"

if [ -n "$EXTENSION" ]; then
    echo "Фільтр за розширенням: *.$EXTENSION"
    FILES_DATA=$(find "$TARGET_DIR" -type f -name "*.$EXTENSION" -printf "%s\n" 2>/dev/null)
else
    echo "Фільтр за розширенням не вказано (рахуємо всі файли)"
    FILES_DATA=$(find "$TARGET_DIR" -type f -printf "%s\n" 2>/dev/null)
fi

count=$(echo "$FILES_DATA" | grep -v '^$' | wc -l)
total_bytes=$(echo "$FILES_DATA" | awk '{s+=$1} END {print s+0}')

format_size() {
    local bytes=$1
    echo "$bytes" | awk '{
        if ($1 < 1024) printf "%d B\n", $1;
        else if ($1 < 1048576) printf "%.2f KB\n", $1/1024;
        else if ($1 < 1073741824) printf "%.2f MB\n", $1/1048576;
        else printf "%.2f GB\n", $1/1073741824;
    }'
}

RESULT_STR="Знайдено файлів: $count | Загальний розмір: $(format_size $total_bytes)"

echo "-------------------------"
echo "Результати (рекурсивно):"
echo "  $RESULT_STR"
echo "-------------------------"

# Логування, якщо вказано в конфігу
if [ -n "$LOG_FILE" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $TARGET_DIR | $EXTENSION | $RESULT_STR" >> "$LOG_FILE" 2>/dev/null
    [ "$VERBOSE" -eq 1 ] && echo "Результати записано в $LOG_FILE"
fi
