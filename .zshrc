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
  copyfile
  copydir
  frontend-search
  nvm
  macos
  z
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias k="kubectl"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(rbenv init -)"
alias pod='arch -x86_64 pod'
alias gsync='git-auto-sync sync'
alias n='v ~/git/personal/notes'
alias c='pbcopy'
alias p='pbpaste'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
