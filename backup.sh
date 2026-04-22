#!/bin/bash
# ~/backup.sh — restic backups to Proton Drive via proton-drive-sync.
#
# Architecture:
#   restic writes encrypted snapshots → ~/ProtonDrive/restic/arch-home/
#   proton-drive-sync daemon           → uploads ~/ProtonDrive/ to Proton Drive
#
# Prerequisites (one-time setup — run in order):
#
#   1. Install tools:
#        sudo pacman -S restic
#
#   2. Authenticate proton-drive-sync:
#        proton-drive-sync auth
#
#   3. Register the sync directory:
#        proton-drive-sync config sync-dir --add ~/ProtonDrive/restic --remote /restic
#
#   4. Start the sync daemon:
#        proton-drive-sync start
#        systemctl --user enable --now proton-drive-sync.service  # if unit exists
#
#   5. Set a strong restic passphrase — remember it, it cannot be recovered:
#        mkdir -p ~/.config/restic
#        printf '%s' 'your-very-strong-passphrase' > ~/.config/restic/password
#        chmod 600 ~/.config/restic/password
#
#   6. Initialise the restic repo (ONE time only):
#        export RESTIC_REPOSITORY="$HOME/ProtonDrive/restic/arch-home"
#        export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"
#        restic init
#
#   7. Enable the daily timer:
#        systemctl --user daemon-reload
#        systemctl --user enable --now restic-backup.timer

set -euo pipefail

export RESTIC_REPOSITORY="$HOME/ProtonDrive/restic/arch-home"
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"

# What to back up — dotfiles are already in GitHub, so focus on
# irreplaceable personal data.
INCLUDES=(
    "$HOME/Pictures"
    "$HOME/Videos"
    "$HOME/Documents"
    "$HOME/dev"
    "$HOME/.ssh"
    "$HOME/.gnupg"
    "$HOME/.mozilla"
    "$HOME/.config/CLAUDE.md"
)

EXCLUDES=(
    --exclude "**/node_modules"
    --exclude "**/target"
    --exclude "**/.venv"
    --exclude "**/__pycache__"
    --exclude "**/.cache"
    --exclude "**/*.pyc"
)

EXISTING=()
for p in "${INCLUDES[@]}"; do
    [[ -e "$p" ]] && EXISTING+=("$p")
done

if (( ${#EXISTING[@]} == 0 )); then
    echo "backup.sh: nothing to back up" >&2
    exit 1
fi

restic backup "${EXISTING[@]}" "${EXCLUDES[@]}"

# Retention: 7 daily, 4 weekly, 6 monthly snapshots.
restic forget --prune \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 6

# Monthly repository integrity check — catches corruption before you need the snapshots.
CHECK_MARKER="$HOME/.config/restic/last-check"
if [[ ! -f "$CHECK_MARKER" ]] || [[ $(find "$CHECK_MARKER" -mtime +30 -print -quit 2>/dev/null) ]]; then
    echo "backup.sh: running monthly restic check..."
    restic check
    touch "$CHECK_MARKER"
fi
