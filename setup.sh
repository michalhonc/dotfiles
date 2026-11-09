#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# link <source> <target>
# Real files/folders at <target> are moved to $BACKUP_DIR first.
# Existing symlinks are replaced.
link() {
  local src="$1" dst="$2"

  if [ ! -e "$src" ]; then
    echo "skip   $dst (missing source $src)"
    return
  fi

  if [ -L "$dst" ]; then
    if [ "$(readlink "$dst")" = "$src" ]; then
      echo "ok     $dst"
      return
    fi
    rm "$dst"
  elif [ -e "$dst" ]; then
    local rel="${dst#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dst" "$BACKUP_DIR/$rel"
    echo "backup $dst -> $BACKUP_DIR/$rel"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link   $dst -> $src"
}

link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/oh-my-zsh.sh" "$HOME/oh-my-zsh.sh"
link "$DOTFILES_DIR/.pi" "$HOME/.pi"
link "$DOTFILES_DIR/.agents" "$HOME/.agents"

# git
link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# Warp (config only; runtime worktrees/ left untracked)
for item in settings.toml workflows tab_configs launch_configurations default_tab_configs; do
  link "$DOTFILES_DIR/warp/$item" "$HOME/.warp/$item"
done

# Warp key repeat: hold a key to repeat it (for example arrows in nvim),
# not the macOS accent picker. Restart Warp after this.
if [ "$(uname)" = "Darwin" ]; then
  defaults write dev.warp.Warp-Stable ApplePressAndHoldEnabled -bool false
  echo "set    Warp ApplePressAndHoldEnabled=false"
fi

if [ -d "$BACKUP_DIR" ]; then
  echo
  echo "Old files moved to $BACKUP_DIR"
fi
