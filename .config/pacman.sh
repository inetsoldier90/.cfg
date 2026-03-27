#!/bin/bash
sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm --needed alacritty
sudo pacman -S --noconfirm --needed base
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed cmake
sudo pacman -S --noconfirm --needed devtools
sudo pacman -S --noconfirm --needed dunst
sudo pacman -S --noconfirm --needed fastfetch
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed go
sudo pacman -S --noconfirm --needed grim
sudo pacman -S --noconfirm --needed hyprland
sudo pacman -S --noconfirm --needed hyprpaper
sudo pacman -S --noconfirm --needed less
sudo pacman -S --noconfirm --needed linux
sudo pacman -S --noconfirm --needed linux-firmware
sudo pacman -S --noconfirm --needed luarocks
sudo pacman -S --noconfirm --needed neovim
sudo pacman -S --noconfirm --needed networkmanager
sudo pacman -S --noconfirm --needed ninja
sudo pacman -S --noconfirm --needed nvidia
sudo pacman -S --noconfirm --needed nvidia-settings
sudo pacman -S --noconfirm --needed nvidia-utils
sudo pacman -S --noconfirm --needed openssh
sudo pacman -S --noconfirm --needed otf-aurulent-nerd
sudo pacman -S --noconfirm --needed otf-codenewroman-nerd
sudo pacman -S --noconfirm --needed otf-comicshanns-nerd
sudo pacman -S --noconfirm --needed otf-commit-mono-nerd
sudo pacman -S --noconfirm --needed otf-droid-nerd
sudo pacman -S --noconfirm --needed otf-firamono-nerd
sudo pacman -S --noconfirm --needed otf-geist-mono-nerd
sudo pacman -S --noconfirm --needed otf-hasklig-nerd
sudo pacman -S --noconfirm --needed otf-hermit-nerd
sudo pacman -S --noconfirm --needed otf-monaspace-nerd
sudo pacman -S --noconfirm --needed otf-opendyslexic-nerd
sudo pacman -S --noconfirm --needed otf-overpass-nerd
sudo pacman -S --noconfirm --needed pipewire
sudo pacman -S --noconfirm --needed pipewire-alsa
sudo pacman -S --noconfirm --needed pipewire-audio
sudo pacman -S --noconfirm --needed pipewire-pulse
sudo pacman -S --noconfirm --needed prettier
sudo pacman -S --noconfirm --needed rofi
sudo pacman -S --noconfirm --needed shfmt
sudo pacman -S --noconfirm --needed slurp
sudo pacman -S --noconfirm --needed stylua
sudo pacman -S --noconfirm --needed sudo
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed ttf-hack-nerd
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed waybar
sudo pacman -S --noconfirm --needed which
sudo pacman -S --noconfirm --needed wireplumber
sudo pacman -S --noconfirm --needed wl-clipboard
sudo pacman -S --noconfirm --needed xdg-desktop-portal-gtk
sudo pacman -S --noconfirm --needed xdg-desktop-portal-hyprland
sudo pacman -S --noconfirm --needed zsh

# AUR Packages
yay -S --noconfirm --needed pyprland
yay -S --noconfirm --needed pyprland-debug
yay -S --noconfirm --needed python-imageio-ffmpeg
yay -S --noconfirm --needed python-screeninfo
yay -S --noconfirm --needed waypaper
yay -S --noconfirm --needed yay
yay -S --noconfirm --needed yay-debug
