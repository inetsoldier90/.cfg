#!/bin/bash
# Swaps the active workspaces between all monitors

TEMP=99

monitors=$(hyprctl monitors -j)
ws_ids=$(echo "$monitors" | jq '[.[].activeWorkspace.id]')
count=$(echo "$ws_ids" | jq 'length')

if [[ "$count" -lt 2 ]]; then
    echo "Need at least 2 monitors"
    exit 1
fi

WS1=$(echo "$ws_ids" | jq '.[0]')
WS2=$(echo "$ws_ids" | jq '.[1]')

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

# Restore focus on the active monitor
active_ws=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
addr=$(hyprctl clients -j | jq -r "[.[] | select(.workspace.id == $active_ws)] | first | .address // empty")
if [[ -n "$addr" ]]; then
    hyprctl dispatch focuswindow "address:$addr"
fi
