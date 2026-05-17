# Repository Architecture for AI Agents and Developers

This document explains the structure and logic of this dotfiles repository to help AI agents and human developers understand how to use, extend, and modify it.

## Architectural Overview

The repository follows a modular, directory-based approach for shell configurations. This design allows for easy categorization and prevents single files from becoming unmanageable.

### Key Components

- **`zsh/activate.sh`**: The main entry point. It dynamically calculates the repository's root directory (`DOTFILES_DIR`) and sources the core modules.
- **`zsh/env.sh`**: The environment variables loader. It sources all `.sh` files inside the `zsh/env/` directory.
- **`zsh/aliases.sh`**: The aliases loader. It sources all `.sh` files inside the `zsh/aliases/` directory.
- **`zsh/completions.sh`**: A standalone script that initializes zsh's `compinit` and loops through a list of tools to source their completions using the standard `tool completion zsh` pattern.
- **`zsh/installers.sh`**: The tool installer loader. It sources all `.sh` files inside `zsh/installers/` and installs missing tools via `brew` or `asdf`. It uses a SHA-1 hashing mechanism to skip checks if configuration hasn't changed.
- **`zsh/theme.sh`**: The theme loader. It sources all `.sh` files inside the `zsh/theme/` directory (e.g., Starship configuration).
- **`zsh/terminal.sh`**: The terminal configuration sync. It ensures the Ghostty configuration is synced between the repository and the local application support directory.

## How to Use

### Integration
Add the following line to your `~/.zshrc`:
```zsh
source <PATH_TO_DOTFILES>/zsh/activate.sh
```

### Adding New Configurations

#### 1. Environment Variables
- Navigate to `zsh/env/`.
- Create a new file with a `.sh` extension (e.g., `zsh/env/project_x.sh`).
- Define your exports: `export PROJECT_X_PATH="/path/to/project"`.
- It will be automatically loaded upon starting a new shell or re-sourcing `activate.sh`.

#### 2. Aliases
- Navigate to `zsh/aliases/`.
- Create a new file with a `.sh` extension (e.g., `zsh/aliases/docker.sh`).
- Define your aliases: `alias dc='docker-compose'`.
- It will be automatically loaded.

#### 3. Autocompletions
- Open `zsh/completions.sh`.
- Find the `tools` array.
- Add the name of the CLI tool to the array.
- Note: This assumes the tool supports the `tool completion zsh` command.

#### 4. Installers
- Navigate to `zsh/installers/`.
- To add Homebrew tools or casks, edit `zsh/installers/brew.sh` and add them to `brew_tools` or `brew_casks` arrays.
- To add ASDF tools, edit `zsh/installers/asdf.sh` and add them to the `asdf_tools` array using the `tool:version1,version2` format.

#### 5. Themes
- Navigate to `zsh/theme/`.
- Create a new file with a `.sh` extension (e.g., `zsh/theme/my_theme.sh`).
- Define your prompt or theme-specific configurations.
- It will be automatically loaded.

#### 6. Terminal Configuration
- Edit `zsh/terminal/config.ghostty` to update your Ghostty terminal settings.
- The configuration is automatically synced with the Ghostty application support directory on shell startup.

## How to Modify the Core Logic

### Changing the File Extension
If you wish to change the supported file extension from `.sh` to something else:
1. Update the glob patterns in `zsh/env.sh` and `zsh/aliases.sh`.
2. Rename the files in the subdirectories accordingly.

### Adding New Modules
To add a new configuration category (e.g., `functions`):
1. Create a directory `zsh/functions/`.
2. Create a loader script `zsh/functions.sh` that iterates over files in that directory.
3. Update `zsh/activate.sh` to source `zsh/functions.sh`.

## Conventions

- **File Extensions**: Use `.sh` for all script files to maintain consistency across shells, even if the primary target is ZSH.
- **Idempotency**: Scripts should be safe to source multiple times in the same session.
- **Silence**: Non-error output should be redirected to `/dev/null` during shell startup to keep the terminal clean.
