# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

### Environment Variables

export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

# Themes
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git z vi-mode zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
alias vim=nvim
alias gpp="g++ -std=c++11 -o "

### Reseting Username prompt ###
DEFAULT_USER=`whoami`

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black "${PWD##*/}"
}

