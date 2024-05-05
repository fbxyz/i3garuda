#!/bin/bash

# Update remote keyring

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
      installed_packages="$installed_packages\n$package"
    else
      echo "$package is already installed."
    fi
  }

  # List of packages to install

  ### Window Manager and Desktop Environment ###
  window_manager_and_desktop_environment=(
    "i3status"
    "i3-gaps"
    "polybar"
    "rofi"
    "picom"
    "i3blocks"
    "dunst"
    "flameshot"
    "nerd-fonts-git"
    "xorg-xwayland"
  )

  ### Terminal and Terminal Utilities ###
  terminal_and_terminal_utilities=(
    "terminator"
    "neovim"
  )

  ### System Utilities ###
  system_utilities=(
    "fastfetch"
    "network-manager-applet"
    "jq"
    "redshift"
    "chkrootkit"
    "sane-epson-perfection-firmware"
    "nvidia-utils"
  )

  ### Development Tools ###
  development_tools=(
    "base-devel"
    "cmake"
    "git"
  )

  ### Graphic Design and Image Editing Tools ###
  graphic_design_and_image_editing_tools=(
    "feh"
    "scrot"
    "imagemagick"
    "inkscape"
    "krita"
  )

  ### File Management ###
  file_management=(
    "thunar"
    "thunar-archive-plugin"
  )

  ### Office and Productivity Tools ###
  office_and_productivity_tools=(
    "kate"
    "geary"
    "keepassxc"
  )

  ### Gaming Related Tools ###
  gaming_related_tools=(
    "steam"
    "lutris"
    "heroic"
    "proton-ge-custom"
    "protontricks"
    "vkbasalt"
    "mangohud"
    "dxvk-bin"
    "goverlay-bin"
    "gwe"
    "antimicrox"
    "sc-controller"
    "droidcam"
    "xboxdrv"
    "xbox-generic-controller"
  )

  # Combine all the categorized packages
  packages_to_install=(
    "${window_manager_and_desktop_environment[@]}"
    "${terminal_and_terminal_utilities[@]}"
    "${system_utilities[@]}"
    "${development_tools[@]}"
    "${graphic_design_and_image_editing_tools[@]}"
    "${file_management[@]}"
    "${office_and_productivity_tools[@]}"
    "${gaming_related_tools[@]}"
    "weathericons-regular-webfont.ttf" # Fonts
  )

  # Update the system
  echo "Updating the system..."
  sudo pacman -Syu

  # Initialize the list of installed packages
  installed_packages=""

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

  # reshade-linux 
  mkdir -p ~/Documents/reshade-linux
  cd ~/Documents/reshade-linux
  curl -LO https://github.com/kevinlekiller/reshade-steam-proton/raw/main/reshade-linux.sh
  chmod u+x reshade-linux.sh
  ./reshade-linux.sh

  echo "Installation completed. You can now configure your environment and start using the software."

  # List installed packages
  echo -e "\nInstalled packages:"
  echo -e "$installed_packages"

  # Nvidia settings
  sudo nvidia-xconfig --cool-bits=12
  nvidia-settings 
else
  echo "Sudo authentication failed. Exiting..."
  exit 1
fi
