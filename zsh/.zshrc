# Enable Powerlevel10k instant prompt (must be at top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Oh-my-zsh libs
zinit snippet OMZL::git.zsh

# Plugins
zinit snippet OMZP::git
zinit snippet OMZP::vi-mode
zinit light agkozak/zsh-z
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Load p10k config if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Disables zsh vi-mode's clipboard copy
export ZVM_SYSTEM_CLIPBOARD_ENABLED=false

# ZSH options
setopt auto_cd              # Type directory name to cd into it

# User configuration
alias vim=nvim
export EDITOR=nvim

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

# M1 Mac needs this handling for some reason
# Source: https://apple.stackexchange.com/questions/148901/why-does-my-brew-installation-not-work
if [[ $(uname -m) == 'arm64' ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Setup FZF
source <(fzf --zsh)

# Source machine-local config (not tracked in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
