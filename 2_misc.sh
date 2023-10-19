#!/bin/bash

# Miniconda download URL
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# Installation directory in the user's home directory
INSTALL_DIR="$HOME/miniconda"

# Download the Miniconda installation script
wget $MINICONDA_URL -O miniconda_installer.sh

# Ensure the download was successful
if [ $? -eq 0 ]; then
    # Run the Miniconda installation
    bash miniconda_installer.sh -b -f -p $INSTALL_DIR

    # Remove the installation script after use
    rm miniconda_installer.sh

    # Add Miniconda's path to your .bashrc (or .bash_profile) file
    echo 'export PATH="$INSTALL_DIR/bin:$PATH"' >> $HOME/.bashrc

    # Reload the configuration file changes
    source $HOME/.bashrc

    # Check the installation
    conda --version

    echo "Miniconda has been successfully installed in the $INSTALL_DIR directory."
    echo "don't forget to chmod +x install_miniconda.sh"
else
    echo "Miniconda download failed."
fi
