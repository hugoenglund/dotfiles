# github token
export GH_TOKEN=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

# gcloud ADC
export ADC="${HOME}/.config/gcloud/application_default_credentials.json"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# rust
. "$HOME/.cargo/env"
