#!/bin/bash
# Bootstrap script: installs every explicitly-installed package on this
# system. Package lists live alongside this script:
#   ~/pkglist.txt   -- official repo packages
#   ~/aurlist.txt   -- AUR packages (installed via yay)
#
# Regenerate with:
#   pacman -Qenq > ~/pkglist.txt
#   pacman -Qeqm > ~/aurlist.txt
set -euo pipefail

PKGLIST="${HOME}/pkglist.txt"
AURLIST="${HOME}/aurlist.txt"

sudo pacman -Syu --noconfirm

if [[ -s "$PKGLIST" ]]; then
    sudo pacman -S --needed --noconfirm - < "$PKGLIST"
else
    echo "warning: $PKGLIST missing or empty, skipping official packages" >&2
fi

if command -v yay >/dev/null && [[ -s "$AURLIST" ]]; then
    yay -S --needed --noconfirm - < "$AURLIST"
else
    echo "note: yay missing or $AURLIST empty, skipping AUR packages" >&2
fi

# Post-install setup
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/Videos"
