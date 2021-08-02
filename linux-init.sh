#!/usr/bin/bash

pacman -S sudo alacritty nitrogen wmctrl dmenu wget curl xmonad xmonad-contrib xmobar qtile lxappearance qt5ct base-devel git upower ufw obs-studio vi vim neovim mupdf ranger volumeicon network-manager-applet flameshot scrot sagemath octave code bash-completion texlive-most firefox-developer-edition gimp inkscape libreoffice-fresh vlc imagemagick telegram-desktop element-desktop 



git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si

yay -S awesome-git
