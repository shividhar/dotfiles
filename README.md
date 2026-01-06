# dotfiles

My dotfiles setup using [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## Structure

```
dotfiles/
├── Brewfile          # All packages, apps, fonts
├── setup.sh          # Bootstrap script
├── README.md
│
├── zsh/              # Stow package: .zshrc, .zprofile
├── git/              # Stow package: .gitconfig, .config/git/ignore
├── gh/               # Stow package: .config/gh/config.yml
├── graphite/         # Stow package: .config/graphite/aliases
├── claude/           # Stow package: .claude/hooks/
├── nvim/             # Stow package: .config/nvim/
└── iterm2/           # iTerm2 preferences (synced by iTerm2)
```

## New Machine Setup

1. Clone this repo:
   ```bash
   git clone https://github.com/shividhar/dotfiles ~/dotfiles
   cd ~/dotfiles
   ```

2. Run setup:
   ```bash
   ./setup.sh
   ```

3. Restart your shell:
   ```bash
   exec zsh
   ```

## Manual Steps

### iTerm2

Configure iTerm2 to load preferences from dotfiles:
1. Settings → General → Preferences
2. Check "Load preferences from a custom folder"
3. Set to `~/dotfiles/iterm2`

Set font:
1. Settings → Profiles → Text → Font
2. Select "MesloLGS Nerd Font"

### Claude Code

Add notification hooks to `~/.claude/settings.json`:

```json
"hooks": {
  "Stop": [
    {
      "hooks": [
        { "type": "command", "command": "~/.claude/hooks/notify.sh \"Task completed\"" }
      ]
    }
  ],
  "Notification": [
    {
      "matcher": "permission_prompt",
      "hooks": [
        { "type": "command", "command": "~/.claude/hooks/notify.sh \"Permission needed\"" }
      ]
    }
  ]
}
```

**Note:** Ensure Focus Mode allows notifications from `terminal-notifier` in System Settings.

### Machine-Local Config

The setup script creates `~/.gitconfig.local` for your git user/email/GPG key.

Create `~/.zshrc.local` for machine-specific shell settings (not tracked in git):

```bash
# Example ~/.zshrc.local

# PATH additions
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Work-specific
alias pytest='ENV=test uv run pytest --no-cov'
export CORE_WORKSPACE='/Users/you/work/project'

# Docker completions (if installed)
fpath=(/Users/you/.docker/completions $fpath)
autoload -Uz compinit
compinit
```

