#!/bin/bash

# Request sudo privileges and keep them active
sudo -v

# Check if sudo authentication was successful
if [ $? -eq 0 ]; then

  # Update the system
  echo "Updating the system..."
  sudo pacman -Syu

  # Install the i3-gaps window manager and related packages
  echo "Installing i3-gaps and related packages..."
  sudo pacman -S --noconfirm i3status i3-gaps polybar rofi picom  i3blocks

  # Install a terminal emulator and neofetch
  echo "Installing terminal emulator and neofetch..."
  sudo pacman -S --noconfirm kitty neofetch
  if ! grep -q "#neofetch" ~/.bashrc; then
    echo -e "\n#neofetch\nneofetch" >> ~/.bashrc
    echo "Added neofetch command to ~/.bashrc"
  else
      echo "neofetch command is already in ~/.bashrc"
  fi

  # Install image-related packages
  echo "Installing image-related packages..."
  sudo pacman -S --noconfirm feh scrot imagemagick

  # Install fonts
  echo "Installing fonts..."
  sudo pacman -S --noconfirm ttf-roboto ttf-font-awesome
  mv weathericons-regular-webfont.ttf ~/.local/share/fonts/
  fc-cache -f -v

  # Install essential packages
  echo "Installing essential packages..."
  sudo pacman -S --noconfirm cmake base-devel

  # Install tools
  echo "Installing tools..."
  sudo pacman -S --noconfirm thunar inkscape flameshot nitrogen jq barrier dunst kate ark geary

  # Install git
  echo "Installing git..."
  sudo pacman -S --noconfirm git

  # Install redshift and arandr
  echo "Installing redshift and arandr..."
  sudo pacman -S --noconfirm redshift arandr

  # Install KeePassXC
  echo "Installing KeePassXC..."
  sudo pacman -S --noconfirm keepassxc

  # Firewall rule for Barrier
  sudo firewall-cmd --zone=public --add-port=24800/tcp --permanent

  echo "Installation completed. You can now configure your environment and start using the software."
else
  echo "Sudo authentication failed. Exiting..."
  exit 1
fi
