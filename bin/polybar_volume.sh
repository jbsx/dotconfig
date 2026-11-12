#!/usr/bin/env bash
# Volume display for polybar (custom/script, tail = true).
# Uses pactl rather than polybar's internal/pulseaudio module, which aborts on
# the next volume change after the audio server restarts (toggle_audio.sh
# restarts pipewire-pulse to re-probe HDMI). pactl reconnects on every call.

MUTED_COLOR="#e67e80"

emit() {
    local vol mute icon
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -m1 -oE '[0-9]+%' | head -n1 | tr -d '%') || return
    [ -n "$vol" ] || return
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null)
    if [ "$mute" = "Mute: yes" ]; then
        echo "%{F$MUTED_COLOR}󰝟 muted%{F-}"
        return
    fi
    if [ "$vol" -lt 34 ]; then icon="󰕿"
    elif [ "$vol" -lt 67 ]; then icon="󰖀"
    else icon="󰕾"
    fi
    printf '%s %3d%%\n' "$icon" "$vol"
}

trap 'kill "$SUBSCRIBE_PID" 2>/dev/null' EXIT
trap 'exit 0' TERM INT
LAST=""
while true; do
    exec 3< <(pactl subscribe 2>/dev/null)
    SUBSCRIBE_PID=$!
    while true; do
        line=$(emit)
        if [ -n "$line" ] && [ "$line" != "$LAST" ]; then
            echo "$line"
            LAST=$line
        fi
        read -r event <&3 || break
        # only sink / server events can change the default sink's volume
        until [[ $event == *" on sink "* || $event == *" on server "* ]]; do
            read -r event <&3 || break 2
        done
    done
    exec 3<&-
    sleep 1
done
