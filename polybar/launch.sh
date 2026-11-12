#!/usr/bin/env sh
# Launch polybar on every monitor. Kills any running instance first.

pkill -x polybar 2>/dev/null
# wait for processes to die
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 0.5; done

polybar --reload main >/tmp/polybar-main.log 2>&1 &
# second bar only when the DVI monitor is connected (desktop only)
if xrandr --query | grep -q "^DVI-D-0 connected"; then
    polybar --reload dvi  >/tmp/polybar-dvi.log  2>&1 &
fi
