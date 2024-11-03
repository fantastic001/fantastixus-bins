#!/bin/bash

# Step 1: Find the Wi-Fi interface name using nmcli
wifi_interface=$(nmcli device status | awk '$2 == "wifi" && $3 == "connected" {print $1}')

# Check if a Wi-Fi interface was found
if [ -z "$wifi_interface" ]; then
    echo "No Wi-Fi interface connected."
    exit 1
fi

# Step 2: Get the private IP address associated with the Wi-Fi interface
private_ip=$(ip -4 addr show "$wifi_interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Check if a private IP was found
if [ -z "$private_ip" ]; then
    echo "No IP address found on interface $wifi_interface."
    exit 1
fi

# Step 3: Update the IP address on Google Drive using rclone
echo "$private_ip" > /tmp/private_ip.txt
# write to file on drive://private_ip.txt 
# delete old one if it exists 
rclone delete drive://private_ip.txt
rclone copy /tmp/private_ip.txt drive://private_ip.txt


# Cleanup temporary file
rm /tmp/private_ip.txt

echo "Updated private IP ($private_ip) on Google Drive successfully."
