echo "" >> reinstall_pacman_split.sh
echo "# AUR Packages" >> reinstall_pacman_split.sh

pacman -Qqm | while read -r pkg; do
  echo "yay -S --noconfirm --needed $pkg" >> reinstall_pacman_split.sh
done

