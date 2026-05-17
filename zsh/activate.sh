# ZSH Configuration Activator
# This script sources all zsh-related configurations

# Path to the dotfiles directory (parent of the directory where this script resides)
export DOTFILES_DIR="${0:A:h:h}"

# Load configurations
[ -f "${0:A:h}/env.sh" ] && source "${0:A:h}/env.sh"
[ -f "${0:A:h}/aliases.sh" ] && source "${0:A:h}/aliases.sh"
[ -f "${0:A:h}/completions.sh" ] && source "${0:A:h}/completions.sh"
[ -f "${0:A:h}/installers.sh" ] && source "${0:A:h}/installers.sh"
[ -f "${0:A:h}/theme.sh" ] && source "${0:A:h}/theme.sh"
[ -f "${0:A:h}/terminal.sh" ] && source "${0:A:h}/terminal.sh"
