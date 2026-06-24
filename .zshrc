autoload -Uz compinit
compinit

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/mhonc@dnanexus.com/.oh-my-zsh"

export OLLAMA_HOST="http://100.126.12.68:11434"

# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"

plugins=(B
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

alias c="clear"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias cop="copilot"
alias cplt="copilot"
alias cc="claude"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

get_git_title() {
  # 1. Get the path to the main/common .git directory
  local common_dir=$(git rev-parse --git-common-dir 2>/dev/null)

  # If not in a git repo, just return the current folder name
  if [[ -z "$common_dir" ]]; then
    echo -n "$(basename "$PWD")"
    return
  fi

  # 2. Get the "True" Repo Name
  # If common_dir is just ".git", we are in the main repo root. 
  # If it's a path, we follow it to the main repo folder.
  local repo_root=$(builtin cd "$common_dir/.." && pwd)
  local repo_name=$(basename "$repo_root")

  # 3. Get the Current Branch
  local branch=$(git branch --show-current 2>/dev/null)

  echo -n "${repo_name}:${branch}"
}

set_iterm_title() {
  echo -ne "\e]1;$(get_git_title)\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set_iterm_title
add-zsh-hook preexec set_iterm_title

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
export PNPM_HOME="/Users/mhonc@dnanexus.com/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# export JAVA_HOME=$(/usr/libexec/java_home -v"11")
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
export DNA_NEXUS_USER_CERTIFICATE_PATH="/Users/mhonc@dnanexus.com/mhonc.dnanexus.com+3.pem"
export DNA_NEXUS_USER_KEY_PATH="/Users/mhonc@dnanexus.com/mhonc.dnanexus.com+3-key.pem"
export PATH="/Users/$USER/Library/Python/3.9/bin:$PATH"

# bun completions
[ -s "/Users/mhonc@dnanexus.com/.bun/_bun" ] && source "/Users/mhonc@dnanexus.com/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f /opt/homebrew/share/forgit/forgit.plugin.zsh ] && source /opt/homebrew/share/forgit/forgit.plugin.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# opencode
export PATH=/Users/mhonc@dnanexus.com/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
