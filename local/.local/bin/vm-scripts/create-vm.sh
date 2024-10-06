#!/bin/bash

# Configuration variables
VM_NAME=$1
MEMORY=2048  # Memory in MB
VCPUS=2      # Number of virtual CPUs
DISK_SIZE=20G  # Disk size in GB
ISO_PATH="/var/lib/libvirt/images/ubuntu.iso"  # Path to ISO image
NETWORK_BRIDGE="ovsbr0"  # Open vSwitch bridge
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"  # Disk path

# Check if VM name is provided
if [ -z "$VM_NAME" ]; then
    echo "Usage: $0 <vm-name>"
    exit 1
fi

# Create a new disk image
echo "Creating disk image for $VM_NAME..."
qemu-img create -f qcow2 $DISK_PATH $DISK_SIZE

# Install the VM using virt-install
echo "Starting VM installation for $VM_NAME..."
virt-install \
  --name $VM_NAME \
  --memory $MEMORY \
  --vcpus $VCPUS \
  --disk path=$DISK_PATH,format=qcow2 \
  --cdrom $ISO_PATH \
  --network bridge=$NETWORK_BRIDGE,model=virtio \
  --os-type linux \
  --os-variant ubuntu20.04 \
  --graphics vnc \
  --noautoconsole \
  --virt-type kvm

echo "VM $VM_NAME is being installed."
