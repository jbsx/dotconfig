#!/bin/bash
# Set up a Fedora + i3 machine with these dotfiles. Run from the repo root.
# Existing files are backed up to ~/.dotfiles-backup/<timestamp>/ before being replaced.
set -e
REPO="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

echo "==> Installing packages"
sudo dnf install -y --skip-unavailable \
    i3 i3lock polybar picom rofi alacritty nitrogen dunst flameshot \
    xclip xrandr setxkbmap xrdb xinit xinput blueman playerctl brightnessctl \
    pavucontrol pulseaudio-utils NetworkManager-tui jq htop s-tui \
    zsh tmux neovim git curl unzip ripgrep fd-find gcc make \
    thunar firefox lightdm lightdm-gtk

# Put a file in place, backing up whatever was there
place() {
    local src="$REPO/$1" dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "${dst#$HOME/}")"
        mv "$dst" "$BACKUP/${dst#$HOME/}"
    fi
    mkdir -p "$(dirname "$dst")"
    cp -r "$src" "$dst"
}

echo "==> Copying configs"
place i3/config                ~/.config/i3/config
place polybar                  ~/.config/polybar
place picom/picom.conf         ~/.config/picom/picom.conf
place alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
place nvim                     ~/.config/nvim
place thunar/accels.scm        ~/.config/Thunar/accels.scm
for f in .zshrc .zshenv .tmux.conf .Xresources .xinitrc .xbindkeysrc .clang-format; do
    place "$f" "$HOME/$f"
done
for f in clipd clippick polybar_volume.sh toggle_audio.sh; do
    place "bin/$f" "$HOME/.local/bin/$f"
done
chmod +x ~/.local/bin/{clipd,clippick,polybar_volume.sh,toggle_audio.sh} ~/.config/polybar/launch.sh ~/.xinitrc
mkdir -p ~/Pictures/Screenshots

echo "==> Installing touchpad/TrackPoint config"
sudo install -Dm644 "$REPO/X11/40-libinput.conf" /etc/X11/xorg.conf.d/40-libinput.conf

echo "==> Installing LiterationMono Nerd Font"
if ! fc-list | grep -q "LiterationMono Nerd Font"; then
    tmp=$(mktemp -d)
    curl -fL -o "$tmp/font.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/LiberationMono.zip
    mkdir -p ~/.local/share/fonts/LiterationMono
    unzip -o -q "$tmp/font.zip" -d ~/.local/share/fonts/LiterationMono
    rm -rf "$tmp"
    fc-cache -f
fi

echo "==> Installing oh-my-zsh"
if [ ! -d ~/.oh-my-zsh ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
[ "$SHELL" = "$(command -v zsh)" ] || chsh -s "$(command -v zsh)"

echo
echo "Done. Backups (if any) are in $BACKUP"
echo "Log out and pick the i3 session (or run startx). Laptop-specific things to check:"
echo "  - ~/.config/i3/config: the xrandr line and 'workspace N output' pins are for the desktop monitors"
echo "  - ~/.config/polybar/config.ini: network 'interface' (see 'ip link') and temperature 'hwmon-path'"
echo "  - ~/.local/bin/toggle_audio.sh: sink names are for the desktop sound card"
echo "  - touchpad/TrackPoint speed + natural scroll: X11/40-libinput.conf (AccelSpeed, -1..1)"
