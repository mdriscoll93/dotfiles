#!/bin/bash

# USB Prep Script for ISO Writing
# This script will prepare a USB device for ISO writing by optionally wiping it
# and setting up a partition table in either GPT or BIOS (msdos) format.

# Usage: usb-prep.sh /dev/sdX [--wipe] [--table=gpt|bios]
#   - /dev/sdX: The USB device to prepare (e.g., /dev/sdb)
#   - --wipe: Optional. Wipes the entire USB with zeros (data-destructive)
#   - --table: Optional. Choose partition table type, "gpt" or "bios" (default: gpt)

# Help message function
show_help() {
  echo "USB Prep Script for ISO Writing"
  echo "Usage: usb-prep.sh /dev/sdX [--wipe] [--table=gpt|bios]"
  echo "  - /dev/sdX: The USB device to prepare (e.g., /dev/sdb)"
  echo "  - --wipe: Optional. Wipes the entire USB with zeros (data-destructive)"
  echo "  - --table: Optional. Choose partition table type, 'gpt' or 'bios' (default: gpt)"
  exit 0
}

# Check if help was requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_help
fi

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Check if device is provided
if [ -z "$1" ]; then
  echo "Error: No device specified."
  echo "Usage: $0 /dev/sdX [--wipe] [--table=gpt|bios]"
  exit 1
fi

DEVICE=$1
WIPE=false
TABLE_TYPE="gpt"  # Default to GPT

# Parse options
for arg in "$@"; do
  case $arg in
    --wipe)
      WIPE=true
      shift
      ;;
    --table=*)
      TABLE_TYPE="${arg#*=}"
      if [[ "$TABLE_TYPE" != "gpt" && "$TABLE_TYPE" != "bios" ]]; then
        echo "Error: Invalid table type. Use 'gpt' or 'bios'."
        exit 1
      fi
      shift
      ;;
    *)
      ;;
  esac
done

# Confirm device and operation
echo "Preparing $DEVICE with $TABLE_TYPE partition table."
[ "$WIPE" = true ] && echo "Warning: This will wipe all data on $DEVICE."

read -p "Are you sure you want to proceed? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 1
fi

# Check if device exists
if [ ! -b "$DEVICE" ]; then
  echo "Error: Device $DEVICE not found. Please check the device name."
  exit 1
fi

# Optional: Wipe the USB with zeros
if [ "$WIPE" = true ]; then
  echo "Wiping $DEVICE with zeros..."
  dd if=/dev/zero of=$DEVICE bs=4M status=progress oflag=sync
fi

# Create partition table
echo "Creating $TABLE_TYPE partition table on $DEVICE..."
if [[ "$TABLE_TYPE" == "gpt" ]]; then
  parted $DEVICE --script mklabel gpt
else
  parted $DEVICE --script mklabel msdos
fi

echo "USB preparation complete. You can now write an ISO to $DEVICE."

