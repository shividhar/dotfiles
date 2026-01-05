#!/bin/bash
set -e

GREEN='\033[0;32m'
NC='\033[0m'

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    printf "${GREEN}Installing Homebrew...${NC}\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    printf "${GREEN}Homebrew already exists. Skipping install.${NC}\n"
fi

# Install all packages from Brewfile
printf "${GREEN}Installing packages from Brewfile...${NC}\n"
brew bundle --file=./Brewfile

# Stow all configs
printf "${GREEN}Symlinking dotfiles with stow...${NC}\n"
stow zsh git gh graphite claude nvim

# Setup ZSH plugins (zinit bootstraps itself in .zshrc)
printf "${GREEN}Initializing zinit plugins...${NC}\n"
zsh -ic "exit" 2>/dev/null || true

# Setup neovim plugins (lazy.nvim bootstraps itself)
printf "${GREEN}Syncing neovim plugins...${NC}\n"
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

# Configure git user info (optional) - creates ~/.gitconfig.local
printf "\n${GREEN}Git Configuration${NC}\n"
if [ -f ~/.gitconfig.local ]; then
    printf "~/.gitconfig.local already exists. Skipping.\n"
else
    read -p "Do you want to configure Git user info? [y/N] " configure_git
    if [[ "$configure_git" =~ ^[Yy]$ ]]; then
        read -p "Enter your Git name: " git_name
        read -p "Enter your Git email: " git_email
        read -p "Enter GPG signing key ID (or press Enter to skip): " gpg_key

        # Create ~/.gitconfig.local with personal settings
        cat > ~/.gitconfig.local << EOF
# Machine-specific git settings (not tracked in dotfiles)
[user]
    name = $git_name
    email = $git_email
EOF

        if [ -n "$gpg_key" ]; then
            cat >> ~/.gitconfig.local << EOF
    signingkey = $gpg_key
EOF
        fi

        # Add credential helper if git-credential-manager is installed
        if command -v git-credential-manager &> /dev/null; then
            cat >> ~/.gitconfig.local << EOF
[credential]
    helper = $(which git-credential-manager)
EOF
        fi

        printf "Created ~/.gitconfig.local\n"
    else
        printf "Skipping Git configuration. You can create ~/.gitconfig.local later.\n"
    fi
fi

printf "\n${GREEN}Done! See README.md for manual steps:${NC}\n"
printf "  1. Configure iTerm2 to load prefs from ~/dotfiles/iterm2\n"
printf "  2. Add Claude Code hooks to ~/.claude/settings.json\n"
printf "  3. Set terminal font to 'MesloLGS Nerd Font'\n"
printf "  4. Create ~/.zshrc.local for machine-specific config (postgres, docker, etc.)\n"
