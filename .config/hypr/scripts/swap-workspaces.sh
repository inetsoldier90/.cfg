#!/bin/bash
# Usage: swap-workspaces.sh <ws1> <ws2>

WS1=$1
WS2=$2
TEMP=99

if [[ -z "$WS1" || -z "$WS2" ]]; then
    echo "Usage: $0 <workspace1> <workspace2>"
    exit 1
fi

move_windows() {
    local from=$1
    local to=$2
    hyprctl clients -j \
        | jq -r ".[] | select(.workspace.id == $from) | .address" \
        | while read -r addr; do
            hyprctl dispatch movetoworkspacesilent "$to,address:$addr"
        done
}

move_windows "$WS1" "$TEMP"
move_windows "$WS2" "$WS1"
move_windows "$TEMP" "$WS2"
