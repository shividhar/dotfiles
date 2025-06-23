#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Install Homebrew
if ! command -v brew &> /dev/null
then
    printf "${GREEN} Installing Homebrew\n\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# From the Homebrew installation guide
# - Run these commands in your terminal to add Homebrew to your PATH:
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    printf "${GREEN} Homebrew already exists. Skipping install.\n\n"
fi

packages=(
  binutils
  coreutils
  findutils
  git
  neovim
  fzf
  trash
)

brew install ${packages[@]}

# Setup iTerm2 with custom preferences
if [ ! -e /Applications/iTerm.app ]; then
    brew install --cask iterm2
else
    printf "${GREEN}iTerm2 already exists. Skipping install.\n\n"
fi

# Github Credentials Manager
if ! command -v git-credential-manager &> /dev/null
then
    brew install --cask git-credential-manager
else
    printf "${GREEN}Github Credentials Manager already exists. Skipping install.\n\n"
fi

# Set Font to Menlo-for-powerline
printf "${GREEN}Copying 'menlo-for-powerline.ttf' font into /Library/Fonts/ if it doesn't already exist.\n\n"
cp -n ./resources/menlo-for-powerline.ttf /Library/Fonts/

read -p "Do you wish to copy the iterm2 preferences?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp ./resources/com.googlecode.iterm2.plist ~/Library/Preferences/
else
    printf "\n"
fi

# Setup ZSH
if  test -d ~/antigen; then
    printf "${GREEN}~/antigen already exists. Skipping install.\n\n"
else
    printf "${GREEN} Installing antigen plugin manager for zsh ${NC}\n\n"
    git clone https://github.com/zsh-users/antigen.git ~/antigen
fi

if ! command -v zsh &> /dev/null
then
    printf "${GREEN}Installing ZSH\n\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    printf "${GREEN}ZSH already exists. Skipping install.\n\n"
fi

if  test -d $HOME/.local/share/nvim; then
    printf "${GREEN}Vim-plug already installed. Skipping install.\n\n"
else
    printf "${GREEN}Installing vim-plug. Plugin manager for Vim/Neovim.\n\n"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

printf "${GREEN}Installing plugins with vim-plug..."
nvim --headless +PlugUpgrade +qall
nvim --headless +PlugInstall +qall

######### Setup sym-linking from dotfiles/home directory to $HOME/ #########
if ! command -v homesick &> /dev/null
then
    printf "${GREEN}Installing homesick\n\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    printf "${GREEN}homesick already exists. Skipping install.\n\n"
fi

# TODO(shivdhar): Figure out a better way to symlink dotfiles from this repo to
# the local envirnoment than this!!!
gem install homesick
# homesick clone 'shividhar/dotfiles'
homesick link dotfiles
homesick pull dotfiles
