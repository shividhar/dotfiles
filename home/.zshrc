source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle z
antigen bundle vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme agnoster

# Tell Antigen that you're done.
antigen apply

# User configuration

### Reseting Username prompt ###
DEFAULT_USER=`whoami`

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black "${PWD##*/}"
}

alias vim=nvim

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

# M1 Mac needs this handling for some reason
# Source: https://apple.stackexchange.com/questions/148901/why-does-my-brew-installation-not-work
if [[ $(uname -m) == 'arm64' ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
