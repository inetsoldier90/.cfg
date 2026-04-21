# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles/configuration directory for an Arch Linux system running Hyprland (Wayland compositor). It is not a software project — there are no build steps, tests, or CI pipelines.

## Hardware

- Dual monitor setup
- NVIDIA GPU (uses `nvidia`, `nvidia-utils`, `nvidia-drm` — env vars set in hyprland.conf)
- Compact keyboard: no Print key, no numpad. Nav cluster: INS, HM, PU, DEL, END, PD
- German keyboard layout (`kb_layout = de`)

## System Setup

To bootstrap a new system, run:
```bash
bash /home/inet/.config/pacman.sh
```
This installs all packages (core tools, Hyprland, Neovim, fonts, audio, CLI tools, AUR packages via yay).

Post-install: run `tldr --update` once to populate tealdeer cache.

## Key Configurations

### Neovim (`nvim/`)

**Entry point**: `nvim/init.lua` → loads `lua/inetsoldier/`

**Structure**:
- `lua/inetsoldier/set.lua` — vim options (4-space indent, relative numbers, 80-col marker)
- `lua/inetsoldier/remap.lua` — keybindings (leader = space)
- `lua/inetsoldier/lazy_init.lua` — Lazy.nvim bootstrap
- `lua/inetsoldier/lazy/` — one file per plugin group

**Plugin management**: Lazy.nvim (lock file: `lazy-lock.json`)

**LSP servers** (auto-installed via Mason): `lua_ls`, `rust_analyzer`, `gopls`

**Formatters** (via conform.nvim): `stylua` (Lua), `gofmt`/`goimports` (Go), `shfmt` (shell), `prettier` (JSON/YAML)

**Key leader mappings**:
- `<leader>pf` — telescope find files
- `<leader>ps` — telescope live grep
- `<leader>gs` — git status (fugitive)
- `<leader>f` — format buffer
- `<leader>tt` — trouble.nvim diagnostics toggle
- `<C-p>` — git files
- `<C-e>` — harpoon menu
- `[t` / `]t` — prev/next diagnostic (trouble.nvim)

### Hyprland (`hypr/`)

**Main config**: `hypr/hyprland.conf`

**Theme split**: `hypr/themes/common.conf` + `hypr/themes/theme.conf`

**Autostarted**: waybar, waypaper, dunst, cliphist, pipewire, pyprland, hypridle

**Scripts**: `hypr/scripts/` — custom shell scripts
- `swap-monitors.sh` — swaps active workspaces between monitors (requires `jq`)

**Key bindings** (Super = mod key):

| Binding | Action |
|---|---|
| `Super+Q` | Terminal (kitty) |
| `Super+E` | Dolphin file manager |
| `Super+Y` | Yazi terminal file manager |
| `Super+R` | Rofi app launcher (drun mode) |
| `Super+C` | Kill active window |
| `Super+M` | Exit Hyprland |
| `Super+L` | Hyprlock |
| `Super+V` | Toggle floating |
| `Super+P` | Pseudo tile (dwindle) |
| `Super+J` | Toggle split (dwindle) |
| `Super+S` | Toggle scratchpad |
| `Super+Shift+S` | Move to scratchpad |
| `Super+[1-9]` | Switch workspace |
| `Super+Shift+[1-9]` | Move window to workspace |
| `Super+arrows` | Move focus |
| `Super+Alt+arrows` | Resize active window (40px steps) |
| `Super+Shift+W` | Swap workspaces between monitors |
| `Super+Insert` | Full screenshot → save + clipboard |
| `Super+Shift+Insert` | Region screenshot → save + clipboard |
| `Super+Ctrl+Insert` | Region screenshot → satty annotation |
| `Super+Shift+V` | Clipboard history picker (cliphist + rofi) |
| `Super+Shift+P` | Color picker (hyprpicker, copies hex) |
| `Super+Alt+R` | Toggle screen recording (wf-recorder) |
| `Alt+Tab` | Focus last window |

**Windowrule syntax**: uses new block syntax (`windowrule { name = ...; match:class = ...; }`) — not the deprecated `windowrulev2` inline form.

**Gestures**: `workspace_swipe` was removed from Hyprland — use `gesture =` directive instead if needed.

### Terminal — Kitty

Kitty is the primary terminal. Alacritty is also installed but secondary.

**Config**: `kitty/kitty.conf`
- Font: Hack Nerd Font Mono 14pt
- Shell: zsh
- `allow_remote_control yes` + `shell_integration enabled` — required for yazi image previews
- `term xterm-kitty` for true color

### Shell — Zsh

**Config**: `~/.zshrc`

**Plugin manager**: antigen with oh-my-zsh
**Prompt**: starship (`~/.config/starship.toml`) — shows dir, git, Go, Rust, Node, command duration
**Plugins**: git, tmux, command-not-found, zsh-syntax-highlighting, zsh-autosuggestions

**Key tools and aliases**:
- `ls` / `ll` / `la` / `tree` → eza (with icons + git status)
- `cat` → bat (syntax highlighting, no paging)
- `cd` → zoxide (frecency-based, `--cmd cd`)
- `y` — yazi wrapper that cds to last directory on exit
- `n` / `vim` / `vi` → nvim
- `config` — git alias for dotfiles bare repo

**fzf key bindings**: `Ctrl+R` (history), `Ctrl+T` (files), `Alt+C` (cd)

### CLI Tools

Notable installed tools: `fzf`, `zoxide`, `eza`, `bat`, `fd`, `ripgrep`, `btop`, `lazygit`, `git-delta`, `tealdeer`, `starship`, `yazi`, `hyprpicker`, `wf-recorder`, `satty`, `obs-studio`

### Git (`~/.gitconfig`)

- Default branch: `main`
- Pager: `delta` (side-by-side diffs, line numbers)
- Editor: nvim
- Merge tool: nvimdiff

### Tmux (`~/.tmux.conf`)

- Prefix: `Ctrl+A`
- Base index: 1 (windows and panes)
- Split: `|` horizontal, `-` vertical (opens in current path)
- Mouse: enabled
- Vi mode keys
- `tmux-256color` with true color passthrough (`terminal-overrides`)
- `Alt+arrows` to switch panes without prefix

### Rofi (`rofi/config.rasi`)

App launcher replacing wofi. Modes: `drun`, `run`, `window`. Papirus icons, fuzzy matching, Catppuccin-ish color scheme (dark bg `#14141c`, accent `#86aaec`).

### Yazi (`yazi/yazi.toml`)

Terminal file manager with image previews (via kitty graphics protocol).
- Text/code files → nvim
- Everything else → xdg-open
- Use the `y` shell function (not `yazi` directly) to cd on exit

### Starship (`starship.toml`)

Prompt modules: directory, git branch/status, Go, Rust, Node, command duration (>2s). Success/error character: `❯`.

## Git Ignore

`git/ignore` globally excludes `.claude/settings.local.json` — Claude Code's local permission settings are not committed.
