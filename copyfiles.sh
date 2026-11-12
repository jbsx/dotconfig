#!/bin/bash
# Snapshot this machine's configs into the repo. Run from the repo root.
set -e
cp -r "$HOME/.config/nvim/." nvim/
cp "$HOME/.config/i3/config" i3/config
cp "$HOME/.config/polybar/config.ini" "$HOME/.config/polybar/launch.sh" polybar/
cp "$HOME/.config/picom/picom.conf" picom/
cp "$HOME/.config/alacritty/alacritty.toml" alacritty/
cp "$HOME/.config/Thunar/accels.scm" thunar/
cp "$HOME"/.local/bin/{clipd,clippick,polybar_volume.sh,toggle_audio.sh} bin/
cp "$HOME"/{.zshrc,.zshenv,.bashrc,.tmux.conf,.Xresources,.xinitrc} ./
