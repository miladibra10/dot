CONFIG_PATH=~/.config/starship.toml


cp "${DOTFILES_DIR}/zsh/theme/starship.toml" $CONFIG_PATH

eval "$(starship init zsh)"

bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word