#!/usr/bin/env bash
set -euo pipefail

title="Claude Code"
msg="$1"

# Prefer CLAUDE_PROJECT_DIR if available; fall back to current dir
proj="${CLAUDE_PROJECT_DIR:-$PWD}"
dir="$(basename "$proj")"

# Detect editor: check env vars, allow override, default to cursor
detect_editor() {
    # Allow explicit override
    if [[ -n "${NOTIFY_EDITOR:-}" ]]; then
        echo "$NOTIFY_EDITOR"
        return
    fi

    # Cursor sets this env var
    if [[ -n "${CURSOR_TRACE_DIR:-}" ]]; then
        echo "cursor"
        return
    fi

    # Check bundle identifier (macOS) - Cursor has a distinct bundle ID
    # Cursor: com.todesktop.* or similar, VS Code: com.microsoft.VSCode
    if [[ "${__CFBundleIdentifier:-}" == "com.microsoft.VSCode" ]]; then
        echo "code"
        return
    fi

    # Default to cursor (user's primary editor)
    # Note: TERM_PROGRAM=vscode is set by both VS Code AND Cursor, so we can't use it
    echo "cursor"
}

editor=$(detect_editor)
open_url="${editor}://file${proj}"

# Get the title of the focused Cursor/VS Code window
get_focused_cursor_window_title() {
    local app_name="$1"
    # Use AXMain attribute to get only the focused window, not all windows
    # Returns format: "filename — projectname" (e.g., "notify.sh — dotfiles")
    # Take only first result (before first comma) as defensive measure
    osascript -e "tell application \"System Events\" to get name of first window of application process \"$app_name\" whose value of attribute \"AXMain\" is true" 2>/dev/null | cut -d',' -f1
}

# Detect if we're running in Cursor's integrated terminal or iTerm2
is_running_in_cursor() {
    # TERM_PROGRAM=vscode is set by both VS Code AND Cursor integrated terminals
    [[ "${TERM_PROGRAM:-}" == "vscode" ]]
}

# Check if terminal/editor is currently focused (macOS only)
is_terminal_focused() {
    # Get the frontmost application
    local frontmost
    frontmost=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null || echo "")

    # If running in Cursor's integrated terminal
    if is_running_in_cursor; then
        # Only suppress if Cursor is frontmost AND we're in the same project window
        if [[ "$frontmost" == "Cursor" ]] || [[ "$frontmost" == "Code" ]] || [[ "$frontmost" == "Visual Studio Code" ]]; then
            local window_title
            window_title=$(get_focused_cursor_window_title "$frontmost")

            # Check if the window title contains our project name
            if [[ -n "$dir" ]] && [[ -n "$window_title" ]] && [[ "$window_title" =~ $dir ]]; then
                return 0  # Same window - suppress notification
            fi
        fi
        # Different app or different Cursor window - send notification
        return 1
    fi

    # If running in iTerm2 (not Cursor)
    if [[ "$frontmost" == "iTerm2" ]]; then
        return 0  # Suppress notification - user is looking at iTerm2
    fi

    return 1
}

# Only send notification if terminal is not focused
if ! is_terminal_focused; then
    terminal-notifier \
        -title "${title}" \
        -subtitle "${dir}" \
        -message "${msg}" \
        -sound default \
        -open "${open_url}"
fi
