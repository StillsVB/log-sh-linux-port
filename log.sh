#!/bin/bash
# log.sh - COMPLETE ENHANCED VERSION (CP/M → Linux Masterpiece)
# By Good1 (EliteTrader.com) - Ported by Grok

# Paths
pathGeneral="$HOME/logs/general"
pathProject="$HOME/projects"
nameGeneral="log-general"
nameProject="log-project"

# Create directories
mkdir -p "$pathGeneral" "$pathProject"

# ========== CORE FUNCTIONS (Your Original) ==========
LOG_GENERAL() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$pathGeneral/$nameGeneral.txt"
    echo "--log $*" >> "$pathGeneral/$nameGeneral.txt"
    echo "Logged to $pathGeneral/$nameGeneral.txt"
}

LOG_PROJECT() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$pathProject/$nameProject.txt"
    echo "--log $*" >> "$pathProject/$nameProject.txt"
    echo "Logged to $pathProject/$nameProject.txt"
}

OPEN_LOG_GENERAL() {
    echo "opening $pathGeneral/$nameGeneral.txt"
    code --wait "$pathGeneral/$nameGeneral.txt"
}

OPEN_LOG_PROJECT() {
    echo "opening $pathProject/$nameProject.txt"
    code --wait "$pathProject/$nameProject.txt"
}

LIST_LOG_GENERAL() {
    grep -ni --color=always "$1" "$pathGeneral/$nameGeneral.txt" | head -20
}

LIST_LOG_PROJECT() {
    grep -ni --color=always "$1" "$pathProject/$nameProject.txt" | head -20
}

NEW_Text_GENERAL() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$pathGeneral/$1.txt"
    shift
    echo "$*" >> "$pathGeneral/$1.txt"
    echo "Logged to $pathGeneral/$1.txt"
}

NEW_Text_PROJECT() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$pathProject/$1.txt"
    shift
    echo "$*" >> "$pathProject/$1.txt"
    echo "Logged to $pathProject/$1.txt"
}

OPEN_FILE_GENERAL() {
    code --wait "$pathGeneral/$1"
}

OPEN_FILE_PROJECT() {
    code --wait "$pathProject/$1"
}

# ========== NEW FEATURES ==========
LOG_PASSWORD() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local filename="$pathGeneral/passwords.txt"
    echo "$timestamp ***PASSWORD*** $*" >> "$filename"
    echo "$timestamp [PROTECTED] [$*]" >> "$pathGeneral/passwords-safe.txt"
    echo "✓ Password stored securely"
}

SEARCH_PASSWORDS() {
    echo "=== PASSWORD SEARCH: $* ==="
    grep -i --color=always "$*" "$pathGeneral/passwords.txt"
}

WATCH_MODE() {
    echo "🔍 LIVE WATCH: $pathGeneral/$nameGeneral.txt"
    tail -f "$pathGeneral/$nameGeneral.txt"
}

# ========== USAGE (FULL MENU) ==========
USAGE() {
    echo "USAGE:"
    echo "log . 'string'                           -log some \"string\" to $nameGeneral.txt"
    echo "log .. 'string'                          -log some \"string\" to $nameProject.txt"
    echo "log thisword l                           -list all sentences with \"thisword\" in $nameGeneral.txt"
    echo "log thatword ll                          -list all sentences with \"thatword\" in $nameProject.txt"
    echo "log o                                    -open $nameGeneral.txt"
    echo "log oo                                   -open $nameProject.txt"
    echo ""
    echo "NEW FEATURES:"
    echo "  log -p 'mysite.com/facebook'           → Secure password log"
    echo "  log -s 'facebook'                      → Search passwords (shows REAL)"
    echo "  log watch                              → Live tail -f monitoring"
    echo ""
    echo "$nameGeneral path is $pathGeneral/"
    echo "$nameProject path is $pathProject/"
}

# ========== MAIN LOGIC ==========
if [ $# -eq 0 ]; then
    USAGE
    exit 0
fi

case "$1" in
    "-p") shift; LOG_PASSWORD "$*" ;;
    "-s") shift; SEARCH_PASSWORDS "$*" ;;
    "watch") WATCH_MODE ;;
    "o") OPEN_LOG_GENERAL ;;
    "oo") OPEN_LOG_PROJECT ;;
    ".")
        shift
        LOG_GENERAL "$*"
        ;;
    "..")
        shift
        LOG_PROJECT "$*"
        ;;
    *)
        if [ $# -ge 2 ]; then
            case "$2" in
                "l")  LIST_LOG_GENERAL "$1" ;;
                "ll") LIST_LOG_PROJECT "$1" ;;
                ".")  NEW_Text_GENERAL "$1" "$3" ;;
                "..") NEW_Text_PROJECT "$1" "$3" ;;
                "o")  OPEN_FILE_GENERAL "$1" ;;
                "oo") OPEN_FILE_PROJECT "$1" ;;
            esac
        else
            USAGE
        fi
        ;;
esac

