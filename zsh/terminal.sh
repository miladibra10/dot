# Ghostty Configuration Sync
# Syncs config.ghostty between dotfiles and Ghostty application support directory

LOCAL_GHOSTTY_CONFIG="${DOTFILES_DIR}/zsh/terminal/config.ghostty"
REMOTE_GHOSTTY_DIR="${HOME}/Library/Application Support/com.mitchellh.ghostty"
REMOTE_GHOSTTY_CONFIG="${REMOTE_GHOSTTY_DIR}/config.ghostty"

if [ -f "$LOCAL_GHOSTTY_CONFIG" ]; then
    if [ ! -f "$REMOTE_GHOSTTY_CONFIG" ]; then
        mkdir -p "$REMOTE_GHOSTTY_DIR"
        cp "$LOCAL_GHOSTTY_CONFIG" "$REMOTE_GHOSTTY_CONFIG"
    else
        # Compare modification times
        if [ "$LOCAL_GHOSTTY_CONFIG" -nt "$REMOTE_GHOSTTY_CONFIG" ]; then
            cp "$LOCAL_GHOSTTY_CONFIG" "$REMOTE_GHOSTTY_CONFIG"
        elif [ "$REMOTE_GHOSTTY_CONFIG" -nt "$LOCAL_GHOSTTY_CONFIG" ]; then
            cp "$REMOTE_GHOSTTY_CONFIG" "$LOCAL_GHOSTTY_CONFIG"
        fi
    fi
fi
