#!/bin/bash

# Request sudo privileges and keep them active
sudo -v

# Check if sudo authentication was successful
if [ $? -eq 0 ]; then

  # Define a function to install a package if it's not already installed
  install_if_needed() {
    package="$1"
    if ! pacman -Qs "$package" > /dev/null; then
      echo "Installing $package..."
      sudo pacman -S --needed --noconfirm "$package"
    else
      echo "$package is already installed."
    fi
  }

  # List of packages to install
  packages_to_install=(
    "i3status"
    "i3-gaps"
    "polybar"
    "rofi"
    "picom"
    "network-manager-applet"
    "i3blocks"
    "kitty"
    "fastfetch"
    "feh"
    "scrot"
    "imagemagick"
    "ttf-roboto"
    "ttf-font-awesome"
    "cmake"
    "base-devel"
    "thunar"
    "inkscape"
    "flameshot"
    "nitrogen"
    "jq"
    "barrier"
    "dunst"
    "kate"
    "ark"
    "thunar-archive-plugin"
    "geary"
    "git"
    "redshift"
    "arandr"
    "keepassxc"
  )

  # Update the system
  echo "Updating the system..."
  sudo pacman -Syu

  # Install packages from the list
  for package in "${packages_to_install[@]}"; do
    install_if_needed "$package"
  done

  # Install fonts
  if [ -e "weathericons-regular-webfont.ttf" ]; then
    echo "Installing fonts..."
    sudo pacman -S --needed --noconfirm ttf-roboto ttf-font-awesome
    mv weathericons-regular-webfont.ttf ~/.local/share/fonts/
    fc-cache -f -v
  fi

  # Add fastfetch to .bashrc
  if ! grep -q "#fastfetch" ~/.bashrc; then
    echo -e "\n#fastfetch\nfastfetch -l garuda" >> ~/.bashrc
  fi

  echo "Installation completed. You can now configure your environment and start using the software."

  # List installed packages
  installed_packages=$(pacman -Qq)
  echo -e "\nInstalled packages:"
  echo "$installed_packages"
else
  echo "Sudo authentication failed. Exiting..."
  exit 1
fi
