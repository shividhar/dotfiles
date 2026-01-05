## Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

## Language
export LANG='en_US.UTF-8'

# Aliases
alias gpp="g++ -std=c++11 -o "

alias less='less -rN'
alias mkdir='mkdir -p'

# Darwin
# alias rm='mv --backup=numbered --target-directory=${HOME}/.Trash'
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Java setup
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
