#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"

mkdir -p "$HOME/.config"

ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/oh-my-zsh.sh" "$HOME/oh-my-zsh.sh"
ln -sfn "$DOTFILES_DIR/.pi" "$HOME/.pi"
ln -sfn "$DOTFILES_DIR/.agents" "$HOME/.agents"

# git
ln -sfn "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# Warp (config only; runtime worktrees/ left untracked)
mkdir -p "$HOME/.warp"
for item in settings.toml workflows tab_configs launch_configurations default_tab_configs; do
  ln -sfn "$DOTFILES_DIR/warp/$item" "$HOME/.warp/$item"
done
