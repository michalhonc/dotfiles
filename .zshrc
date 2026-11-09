#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export OLLAMA_HOST="http://100.126.12.68:11434"

# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"

plugins=(
  git
  copyfile
  copypath
  frontend-search
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
alias pod='arch -x86_64 pod'
alias gsync='git-auto-sync sync'
alias n='v ~/git/personal/notes'
alias c='pbcopy'
alias p='pbpaste'
alias vconflict='v `git diff --name-only --diff-filter=U  | uniq`'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Lazy-load nvm: sourcing nvm.sh eagerly costs ~2s at shell startup.
# node itself comes from Volta; nvm loads on first use of the `nvm` command.
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
  elif [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    . "/opt/homebrew/opt/nvm/nvm.sh"
  fi
  nvm "$@"
}

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
# export JAVA_HOME=$(/usr/libexec/java_home -v"11")
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
export PATH="/Users/$USER/Library/Python/3.9/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f /opt/homebrew/share/forgit/forgit.plugin.zsh ] && source /opt/homebrew/share/forgit/forgit.plugin.zsh


# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Pi
export PATH="$HOME/.volta/tools/image/node/24.19.0/bin:$PATH"

# Perl local::lib for albituzka tools
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"

# Secrets live outside the repo (see ~/.zshrc.secrets)
[ -f "$HOME/.zshrc.secrets" ] && source "$HOME/.zshrc.secrets"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Pi
export PATH="/Users/michalhonc/.pi/agent/bin:$PATH"
