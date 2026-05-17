# Configuration Scripts Loader
# This script executes scripts in zsh/configurations/ once unless they have changed.

CONFIGS_DIR="${0:A:h}/configurations"
HASH_FILE="$HOME/.dot/configs.hash"

# Ensure the .dot directory exists
[ -d "$HOME/.dot" ] || mkdir -p "$HOME/.dot"

# Function to get stored hash for a specific file
get_stored_hash() {
    local file_path="$1"
    if [ -f "$HASH_FILE" ]; then
        grep "^$file_path:" "$HASH_FILE" | cut -d: -f2
    fi
}

# Function to update stored hash for a specific file
update_stored_hash() {
    local file_path="$1"
    local new_hash="$2"
    # Create temp file
    local tmp_file=$(mktemp)
    
    if [ -f "$HASH_FILE" ]; then
        # Copy all other files' hashes to temp file
        grep -v "^$file_path:" "$HASH_FILE" > "$tmp_file"
    fi
    # Add new hash
    echo "$file_path:$new_hash" >> "$tmp_file"
    mv "$tmp_file" "$HASH_FILE"
}

if [ -d "$CONFIGS_DIR" ]; then
    for config_file in "$CONFIGS_DIR"/*.sh; do
        [ -e "$config_file" ] || continue
        
        # Calculate current hash of the file
        CURRENT_HASH=$(shasum "$config_file" | awk '{print $1}')
        STORED_HASH=$(get_stored_hash "$config_file")
        
        if [ "$CURRENT_HASH" != "$STORED_HASH" ]; then
            # Source the configuration script
            source "$config_file"
            
            # Update the hash
            update_stored_hash "$config_file" "$CURRENT_HASH"
        fi
    done
fi
