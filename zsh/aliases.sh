# ZSH Aliases Loader
# This script sources all .sh files in the aliases directory

ALIASES_DIR="${0:A:h}/aliases"

if [ -d "$ALIASES_DIR" ]; then
    for alias_file in "$ALIASES_DIR"/*.sh; do
        [ -f "$alias_file" ] && source "$alias_file"
    done
fi
