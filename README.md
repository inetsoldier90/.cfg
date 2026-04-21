# .cfg — dotfiles

Personal Arch Linux + Hyprland configuration, managed as a **bare git repo**
whose working tree is `$HOME`.

## Fresh-machine bootstrap

```bash
# 1. Clone the bare repo
git clone --bare git@github.com:inetsoldier90/.cfg.git "$HOME/.cfg.git"

# 2. Create the shell alias (this lives in .zshrc, but you need it now)
alias config='/usr/bin/git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME'

# 3. Don't show every untracked file in $HOME in `config status`
config config status.showUntrackedFiles no

# 4. Check out the working tree. This will refuse if any of the tracked
#    files already exist; back them up and try again:
mkdir -p "$HOME/.cfg-backup"
config checkout 2>&1 | grep -E '^\s+\.' | awk '{print $1}' | \
    xargs -I{} sh -c 'mkdir -p "$HOME/.cfg-backup/$(dirname {})" && mv "$HOME/{}" "$HOME/.cfg-backup/{}"'
config checkout
config submodule update --init --recursive 2>/dev/null || true

# 5. Install packages (adjust the two list files first if needed)
bash "$HOME/.config/pacman.sh"
```

## Day-to-day

```bash
config status               # what's changed in tracked dotfiles
config diff                 # review edits
config add <path>           # stage a tracked-or-new file
config commit -m "message"
config push
```

Plain `git` inside `$HOME` will do the wrong thing — always use `config`.
Inside an actual project directory (e.g. `~/dev/...`), use `git` normally.

## Layout

| Path | What lives there |
|---|---|
| `.config/CLAUDE.md` | Canonical setup reference (Hyprland, Neovim, shell) |
| `.config/pacman.sh` | Bootstrap installer — consumes `~/pkglist.txt` + `~/aurlist.txt` |
| `.config/hypr/` | Hyprland + hypridle + hyprlock + scripts |
| `.config/nvim/` | Neovim (Lazy.nvim + Mason LSP) |
| `.config/waybar/` `rofi/` `dunst/` `yazi/` `kitty/` `wofi/` | Wayland desktop bits |
| `~/.zshrc` | zsh with zinit (turbo mode) |
| `~/.tmux.conf` `~/.gitconfig` `~/.bashrc` | Standard dotfiles |

## Regenerating the package lists

After installing new pacman/AUR packages, refresh the lists so a fresh
install will include them:

```bash
pacman -Qenq > ~/pkglist.txt     # official repos
pacman -Qeqm > ~/aurlist.txt     # AUR (foreign) packages
config add ~/pkglist.txt ~/aurlist.txt
config commit -m "refresh package lists"
```

## Backups

Dotfiles live here. Everything else in `$HOME` (photos, notes, ssh keys,
browser profile, project code) is **not** in this repo — back it up
separately. See `~/backup.sh` (if present) for the Proton Drive + rclone
setup.
