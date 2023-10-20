#!/bin/bash

# Download vtoyboot ISO
echo "Downloading vtoyboot ISO..."
wget https://github.com/ventoy/vtoyboot/releases/download/v1.0.29/vtoyboot-1.0.29.iso

# Mount the ISO
echo "Mounting vtoyboot ISO..."
sudo mkdir /mnt/vtoyboot
sudo mount -o loop vtoyboot-1.0.29.iso /mnt/vtoyboot

# Extract vtoyboot tar.gz
echo "Extracting vtoyboot tar.gz..."
tar -xf /mnt/vtoyboot/vtoyboot-1.0.29.tar.gz -C /tmp/

# Change directory to vtoyboot
cd /tmp/vtoyboot-1.0.29/

# Launch vtoyboot
echo "Launching vtoyboot..."
sudo bash vtoyboot.sh


# Unmount the ISO
echo "Unmounting vtoyboot ISO..."
sudo umount /mnt/vtoyboot
sudo rmdir /mnt/vtoyboot

# Clean up
echo "Cleaning up..."
rm vtoyboot-1.0.29.iso

# Remove temporary directory
echo "Removing temporary directory..."
sudo rm -rf /tmp/vtoyboot-1.0.29/

echo "vtoyboot installation completed."
