autoload -Uz compinit
compinit

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/michalhonc/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"

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
alias vconflict='v `git diff --name-only --diff-filter=U  | uniq`'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/michalhonc/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# export JAVA_HOME=$(/usr/libexec/java_home -v"11")
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
