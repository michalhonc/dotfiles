# dotfiles

```sh
# Generate ssh key
ssh-keygen -t rsa
```

```sh
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Mathias Bynens"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="mathias@mailinator.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

Macos defaults
https://macos-defaults.com/

## Pi config

Tracked in this repo:

- `.pi`
- `.agents`

Local-only Pi state is ignored via `.gitignore`:

- `.pi/agent/auth.json`
- `.pi/agent/trust.json`
- `.pi/agent/bin/`
- `.pi/agent/sessions/`
- `.pi/agent/npm/node_modules/` (manifest tracked, deps ignored)

## Warp

Warp config is tracked under `warp/` and symlinked into `~/.warp` by `setup.sh`:

- `settings.toml`, `workflows/`, `tab_configs/`, `launch_configurations/`, `default_tab_configs/`

Runtime state (`~/.warp/worktrees/`) is intentionally left untracked.

## git

- `.gitconfig` and `.gitignore_global` are symlinked into `$HOME`.
