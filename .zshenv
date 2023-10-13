# secret stuff
. "$HOME/.my-secrets"

# fzf
export FZF_COMPLETION_TRIGGER=';'
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(command pyenv init -)"
eval "$(command pyenv virtualenv-init -)"

# rust
. "$HOME/.cargo/env"
