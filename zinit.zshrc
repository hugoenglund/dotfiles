# HACK: prevent 'zsh-vi-mode' from overriding keybindings
ZVM_INIT_MODE=sourcing

# 📥
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# 🔌
zinit wait lucid for \
  Aloxaf/fzf-tab \
  OMZP::tmux \
  OMZP::git \
  OMZP::ubuntu \
  OMZL::directories.zsh \
  OMZL::theme-and-appearance.zsh

# NOTE: https://github.com/zdharma-continuum/fast-syntax-highlighting?tab=readme-ov-file#zinit
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    OMZP::colored-man-pages \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# 📦
zinit pack"default+keys" for fzf

# 💅
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ⚡
alias vim='nvim'
alias lzg='lazygit'
alias lzd='lazydocker'
alias cat='batcat'

alias vpn='netExtender -d Nepa -u hugo.englund connect.nepa.com'
alias dmmm="tmux new-session -s dev-mmm -c $HOME/dev/Bayesian-MMM"

# 📚
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# 🧰
export PATH="$PATH:$HOME/.local/bin"
eval "$(zoxide init zsh)"
eval "$(~/.local/bin/mise activate zsh)"

# 🤖
. "$HOME/.cargo/env"
