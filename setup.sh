#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"

mkdir -p "$HOME/.config"

ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/oh-my-zsh.sh" "$HOME/oh-my-zsh.sh"
ln -sfn "$DOTFILES_DIR/.pi" "$HOME/.pi"
ln -sfn "$DOTFILES_DIR/.agents" "$HOME/.agents"
