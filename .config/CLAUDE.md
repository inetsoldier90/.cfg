# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles/configuration directory for an Arch Linux system running Hyprland (Wayland compositor). It is not a software project — there are no build steps, tests, or CI pipelines.

## System Setup

To bootstrap a new system, run:
```bash
bash /home/inet/.config/pacman.sh
```
This installs all packages (core tools, Hyprland, Neovim, fonts, audio, AUR packages via yay).

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
- `<C-p>` — git files
- `<C-e>` — harpoon menu

### Hyprland (`hypr/`)

**Main config**: `hypr/hyprland.conf` — monitor setup, keybindings, autostart, visual settings

**Theme split**: `hypr/themes/common.conf` + `hypr/themes/theme.conf`

**Autostarted**: waybar, waypaper, dunst, cliphist, pipewire, pyprland

**Key bindings** (Super = mod key): `Super+Q` terminal, `Super+E` dolphin, `Super+R` wofi, `Super+[1-9]` workspaces

### Terminal

Both Alacritty and Kitty are configured identically: Hack Nerd Font 14pt, zsh shell.

## Git Ignore

`git/ignore` globally excludes `.claude/settings.local.json` — Claude Code's local permission settings are not committed.
