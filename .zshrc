autoload -Uz compinit
compinit

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/michalhonc/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  copyfile
  copydir
  frontend-search
  nvm
  macos
  z
)

source $ZSH/.zshrc

export EDITOR='nvim'

alias vim="nvim"
alias vi="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias k="kubectl"
