#!/usr/bin/bash

pacman -S sudo sagemath octave code firefox-developer-edition alacritty telegram-desktop element-desktop nitrogen xmonad xmonad-contrib xmobar qtile lxappearance gimp inkscape okular gwenview qbittorrent ranger libreoffice-fresh vlc imagemagick texlive-most base-devel git upower ufw obs-studio vi vim neovim

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si

yay -S awesome-git
