#!/bin/bash



# Create the wallpaper directory if it doesn't exist
mkdir -p /tmp/wallpaper

# Run pscircle and generate wallpapers
i=1
while [ true ]
do
    pscircle --output=/tmp/wallpaper/wall-${i}.png
    # Set wallpaper to the newly generated image
    feh --bg-fill /tmp/wallpaper/wall-${i}.png --bg-fill ~/Images/wallpaper/network.jpg
    # Toggle between -1 and 1 to alternate between different images
    i=$(( ${i}*-1 ))
    sleep 10
done
