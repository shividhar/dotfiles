#!/bin/bash


# Install Homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

packages=(
  binutils
  coreutils
  findutils
  git
  go
  neovim
)

brew install ${packages[@]}

git clone https://github.com/zsh-users/antigen.git ~/antigen
