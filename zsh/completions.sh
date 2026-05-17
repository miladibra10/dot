# Command Autocompletions
# This script automatically sets up completions for a list of CLI tools.

# List of tools to enable completions for
# Add your tools here
tools=(
    kubectl
    kube-linter
    helm
    operator-sdk
    cilium
    crane
    codex
)


# command for zsh-completions
autoload -Uz compinit && compinit

for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        source <($tool completion zsh) 2>/dev/null
    fi
done
