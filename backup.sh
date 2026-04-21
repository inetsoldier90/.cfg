#!/bin/bash
# ~/backup.sh — restic-over-rclone backups to Proton Drive.
#
# Prerequisites (one-time):
#   1. Install tools:
#        sudo pacman -S rclone restic
#   2. Configure rclone with a Proton Drive remote named "proton":
#        rclone config
#      Choose: n (new) -> name: proton -> storage: protondrive
#      Enter Proton email + password + 2FA code when prompted.
#   3. Set a strong restic repository password (stored encrypted, never
#      transmitted — you MUST remember it or back up snapshots are useless):
#        mkdir -p ~/.config/restic
#        printf '%s' 'your-very-strong-passphrase' > ~/.config/restic/password
#        chmod 600 ~/.config/restic/password
#   4. Initialise the repo (ONE time only):
#        export RESTIC_REPOSITORY="rclone:proton:backups/arch-home"
#        export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"
#        restic init
#
# Then run this script manually or from a systemd user timer.

set -euo pipefail

export RESTIC_REPOSITORY="rclone:proton:backups/arch-home"
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"

# What to back up. Keep this list small and intentional — the dotfiles repo
# already covers configs, so we focus on irreplaceable personal data.
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

# What to exclude within those paths (caches, build artefacts, etc.)
EXCLUDES=(
    --exclude "**/node_modules"
    --exclude "**/target"
    --exclude "**/.venv"
    --exclude "**/__pycache__"
    --exclude "**/.cache"
    --exclude "**/*.pyc"
    --exclude "**/.DS_Store"
)

# Keep the included paths that actually exist (restic fails on missing ones)
EXISTING=()
for p in "${INCLUDES[@]}"; do
    [[ -e "$p" ]] && EXISTING+=("$p")
done

if (( ${#EXISTING[@]} == 0 )); then
    echo "backup.sh: nothing to back up" >&2
    exit 1
fi

restic backup "${EXISTING[@]}" "${EXCLUDES[@]}"

# Retention: keep 7 daily, 4 weekly, 6 monthly snapshots.
restic forget --prune \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 6
