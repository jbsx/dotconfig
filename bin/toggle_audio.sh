#!/usr/bin/env bash
SINK1="alsa_output.pci-0000_07_00.6.analog-stereo"
SINK2="alsa_output.pci-0000_07_00.1.hdmi-stereo"
HDMI_CARD="alsa_card.pci-0000_07_00.1"
HDMI_PROFILE="output:hdmi-stereo"

status_icon() {
    local current
    current=$(pactl get-default-sink 2>/dev/null) || return 1
    if [ "$current" = "$SINK1" ]; then
        echo "󰋋"
    else
        echo "󰓃"
    fi
}

if [ "$1" = "status" ]; then
    status_icon
    exit 0
fi

# For polybar with tail = true: print the icon now and again whenever the audio
# server reports a change (e.g. a new default sink). Reconnects after restarts.
if [ "$1" = "watch" ]; then
    trap 'kill "$SUBSCRIBE_PID" 2>/dev/null' EXIT
    trap 'exit 0' TERM INT
    LAST=""
    emit() {
        local icon
        icon=$(status_icon) || return
        [ "$icon" = "$LAST" ] && return
        echo "$icon"
        LAST=$icon
    }
    while true; do
        exec 3< <(pactl subscribe 2>/dev/null)
        SUBSCRIBE_PID=$!
        emit
        while read -r event <&3; do
            [[ $event == *" on server "* ]] && emit
        done
        exec 3<&-
        sleep 1
    done
fi

CURRENT=$(pactl get-default-sink)

sink_exists() {
    pactl list short sinks 2>/dev/null | cut -f2 | grep -qx "$1"
}

hdmi_profile_available() {
    pactl -f json list cards 2>/dev/null | jq -e --arg card "$HDMI_CARD" --arg profile "$HDMI_PROFILE" \
        '.[] | select(.name == $card) | .profiles[$profile].available == true' >/dev/null
}

# wait_for <seconds> <command...>: retry the command until it succeeds or time runs out.
wait_for() {
    local timeout=$1; shift
    for ((i = 0; i < timeout * 4; i++)); do
        "$@" && return 0
        sleep 0.25
    done
    return 1
}

# PipeWire only probes the HDMI card's profiles when it starts, so HDMI 1 goes
# missing if the monitor wasn't ready then. Restart the audio server to re-probe.
ensure_hdmi_sink() {
    sink_exists "$SINK2" && return 0
    if ! hdmi_profile_available; then
        systemctl --user restart wireplumber pipewire pipewire-pulse
        wait_for 10 hdmi_profile_available || return 1
    fi
    pactl set-card-profile "$HDMI_CARD" "$HDMI_PROFILE"
    wait_for 5 sink_exists "$SINK2"
}

if [ "$CURRENT" = "$SINK1" ]; then
    if ensure_hdmi_sink; then
        pactl set-default-sink "$SINK2"
    else
        echo "toggle_audio: HDMI sink not found even after restarting the audio server" >&2
        wait_for 5 sink_exists "$SINK1" && pactl set-default-sink "$SINK1"
    fi
else
    pactl set-default-sink "$SINK1"
fi
