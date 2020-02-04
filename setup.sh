#!/bin/bash


# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

packages=(
  binutils
  coreutils
  findutils
  git
  go
  neovim
  jq
)

brew install ${packages[@]}

# Set Font
cp ./resources/menlo-for-powerline.ttf /Library/Fonts/

cp ./resources/com.googlecode.iterm2.plist ~/Library/Preferences/

# Setup ZSH
git clone https://github.com/zsh-users/antigen.git ~/antigen

# Config files
cp -R ./home/ ~/
