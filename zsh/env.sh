# ZSH Environment Variables Loader
# This script sources all .sh files in the env directory

ENV_DIR="${0:A:h}/env"

if [ -d "$ENV_DIR" ]; then
    for env_file in "$ENV_DIR"/*.sh; do
        [ -f "$env_file" ] && source "$env_file"
    done
fi
