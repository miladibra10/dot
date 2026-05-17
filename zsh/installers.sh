# Tool Installer Loader
# This script checks for the existence of tools and installs them if missing.

INSTALLERS_DIR="${0:A:h}/installers"
HASH_FILE="$HOME/.dot/tools.hash"

# Ensure the .dot directory exists
[ -d "$HOME/.dot" ] || mkdir -p "$HOME/.dot"

# Calculate the combined hash of the installer scripts
# We use shasum (available on macOS) to generate the hash
CURRENT_HASH=$(cat "$0" "$INSTALLERS_DIR"/*.sh 2>/dev/null | shasum | awk '{print $1}')
STORED_HASH=""
[ -f "$HASH_FILE" ] && STORED_HASH=$(cat "$HASH_FILE")

# Load tool lists (always load them so the arrays are available if needed)
if [ -d "$INSTALLERS_DIR" ]; then
    for installer_file in "$INSTALLERS_DIR"/*.sh; do
        [ -f "$installer_file" ] && source "$installer_file"
    done
fi

# Skip installation logic if the hash hasn't changed
if [ "$CURRENT_HASH" = "$STORED_HASH" ]; then
    return 0
fi

# Install Brew tools (formulae)
if command -v brew >/dev/null 2>&1; then
    for tool in "${brew_tools[@]}"; do
        if ! brew list --formula "$tool" >/dev/null 2>&1; then
            echo "Installing $tool via Homebrew..."
            brew install --formula "$tool" >/dev/null
        fi
    done

    # Install Brew casks
    for cask in "${brew_casks[@]}"; do
        if ! brew list --cask "$cask" >/dev/null 2>&1; then
            echo "Installing $cask via Homebrew Cask..."
            brew install --cask "$cask" >/dev/null
        fi
    done
fi

# Install ASDF tools
if command -v asdf >/dev/null 2>&1; then
    for entry in "${asdf_tools[@]}"; do
        tool="${entry%%:*}"
        versions_str="${entry#*:}"
        
        # If no colon found, versions_str will be same as entry, so we default to latest
        if [[ "$tool" == "$versions_str" ]]; then
            versions=("latest")
        else
            # Split versions by comma
            # Note: Using ZSH-style array splitting
            versions=("${(@s:,:)versions_str}")
        fi

        # Check if plugin is installed
        if ! asdf plugin list | grep -q "^$tool$"; then
            echo "Adding asdf plugin for $tool..."
            asdf plugin add "$tool"
        fi
        
        for version in "${versions[@]}"; do
            # Check if specific version is installed
            if ! asdf list "$tool" "$version" >/dev/null 2>&1; then
                echo "Installing $tool $version via ASDF..."
                asdf install "$tool" "$version" >/dev/null 2>&1
                
                # If it's the first version in the list, or the only one, set it as global if none set
                if ! asdf current "$tool" >/dev/null 2>&1; then
                    asdf global "$tool" "$version" >/dev/null 2>&1
                fi
            fi
        done
    done
fi

# Update the stored hash after successful (or attempted) installation
echo "$CURRENT_HASH" > "$HASH_FILE"
