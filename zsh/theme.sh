# ZSH Theme Loader
# This script sources all .sh files in the theme directory

THEME_DIR="${0:A:h}/theme"

if [ -d "$THEME_DIR" ]; then
    for env_file in "$THEME_DIR"/*.sh; do
        [ -f "$env_file" ] && source "$env_file"
    done
fi
