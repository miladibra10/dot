# dot
A repo to contain my personal workspace configurations

## Structure

- `zsh/aliases/`: Directory for categorized zsh aliases.
- `zsh/aliases.sh`: Loader script that applies all aliases from the `aliases/` directory.
- `zsh/env/`: Directory for categorized environment variables.
- `zsh/env.sh`: Loader script that applies all environment variables from the `env/` directory.
- `zsh/completions.sh`: Automatically setup command autocompletions for CLI tools.
- `zsh/configurations/`: Directory for scripts that should be executed once unless they have changed.
- `zsh/configurations.sh`: Loader script that executes scripts in the `configurations/` directory once, using a per-file hashing mechanism.
- `zsh/installers/`: Directory for tool lists to be installed via `brew` or `asdf`.
- `zsh/installers.sh`: Loader script that installs missing tools via `brew` or `asdf`. It uses a hashing mechanism to skip installation if configuration files haven't changed, improving shell startup performance.
- `zsh/theme/`: Directory for theme-specific configurations (e.g., Starship).
- `zsh/theme.sh`: Loader script that applies all configurations from the `theme/` directory.
- `zsh/terminal/`: Directory for terminal-specific configuration files (e.g., Ghostty).
- `zsh/terminal.sh`: Loader script that syncs terminal configurations (e.g., Ghostty).
- `zsh/activate.sh`: Main entry point that sources all zsh configurations.

## Usage

To use these configurations, add the following line to your `~/.zshrc` file:

```zsh
source <PATH_TO_DOT>/zsh/activate.sh
```

After updating your `~/.zshrc`, either restart your terminal or run:

```bash
source ~/.zshrc
```
