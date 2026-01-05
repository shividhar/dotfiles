# dotfiles

My dotfiles setup using [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## Structure

```
dotfiles/
├── Brewfile          # All packages, apps, fonts
├── setup.sh          # Bootstrap script
├── README.md
│
├── zsh/              # Stow package: .zshrc, .zprofile, .zenv
├── git/              # Stow package: .gitconfig, .config/git/ignore
├── gh/               # Stow package: .config/gh/config.yml
├── graphite/         # Stow package: .config/graphite/aliases
├── conda/            # Stow package: .condarc
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

## Adding New Configs

To add a new stow package:

```bash
# Create package directory mirroring home structure
mkdir -p newpkg/.config/appname

# Add config files
cp ~/.config/appname/config newpkg/.config/appname/

# Stow it
stow newpkg

# Add to setup.sh stow command
```

## Updating

After pulling changes:

```bash
cd ~/dotfiles
stow zsh git gh graphite conda claude nvim  # Re-stow to update symlinks
```
