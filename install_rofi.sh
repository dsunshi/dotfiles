#/bin/bash

git clone https://github.com/catppuccin/rofi ./.catppuccin-rofi
cd ./.catppuccin-rofi
mkdir -p ~/.config/rofi ~/.local/share/rofi/themes
cp -r ./.config/rofi/* ~/.config/rofi
cp -r ./.local/share/rofi/themes/* ~/.local/share/rofi/themes/
