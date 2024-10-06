#!/bin/bash

# Configuration variables
VM_NAME=$1
MEMORY=2048  # Memory in MB
VCPUS=2      # Number of virtual CPUs
DISK_SIZE=20G  # Disk size in GB
CLOUD_IMG="/var/lib/libvirt/images/ubuntu-20.04-server-cloudimg-amd64.img"
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"
NETWORK_BRIDGE="ovsbr0"
CLOUD_INIT_ISO="/var/lib/libvirt/images/${VM_NAME}-cloud-init.iso"

# Check if VM name is provided
if [ -z "$VM_NAME" ]; then
    echo "Usage: $0 <vm-name>"
    exit 1
fi

# Create a new disk image
echo "Creating disk image for $VM_NAME..."
qemu-img create -f qcow2 -b $CLOUD_IMG -F qcow2 $DISK_PATH $DISK_SIZE

# Create cloud-init configuration
echo "Creating cloud-init configuration for $VM_NAME..."
mkdir -p /tmp/${VM_NAME}-cloud-init
cat > /tmp/${VM_NAME}-cloud-init/meta-data <<EOF
instance-id: ${VM_NAME}
local-hostname: ${VM_NAME}
EOF

cat > /tmp/${VM_NAME}-cloud-init/user-data <<EOF
#cloud-config
password: ubuntu
chpasswd: { expire: False }
ssh_pwauth: True
EOF

# Create cloud-init ISO
echo "Creating cloud-init ISO..."
genisoimage -output $CLOUD_INIT_ISO -volid cidata -joliet -rock /tmp/${VM_NAME}-cloud-init/user-data /tmp/${VM_NAME}-cloud-init/meta-data

# Extract the numerical disk size for virt-install
NUM_DISK_SIZE=${DISK_SIZE%G}

# Install the VM using virt-install
echo "Starting VM installation for $VM_NAME..."
virt-install \
  --name $VM_NAME \
  --memory $MEMORY \
  --vcpus $VCPUS \
  --disk path=$DISK_PATH,format=qcow2,size=${NUM_DISK_SIZE} \
  --disk path=$CLOUD_INIT_ISO,device=cdrom \
  --network bridge=$NETWORK_BRIDGE,model=virtio,virtualport_type=openvswitch \
  --os-variant ubuntu20.04 \
  --virt-type kvm \
  --import \
  --noautoconsole

echo "VM $VM_NAME has been created."

# Clean up temporary cloud-init files
echo "Cleaning up temporary files..."
rm -rf /tmp/${VM_NAME}-cloud-init
