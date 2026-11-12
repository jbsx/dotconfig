#!/bin/sh
#
# ~/.xinitrc — sourced by `startx`. Starts your X session.

# Load X resources (cursor theme/size, fonts, etc.)
xrdb -merge "$HOME/.Xresources"

# Cursor size for apps that read the env var
export XCURSOR_SIZE=16

# Give systemd user services (xdg-desktop-portal, etc.) access to X
systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY

exec i3 > ~/.i3.log 2>&1

(cd $HOME/Projects/usage_dashboard && nohup pnpm run start > /dev/null 2>&1 &)
