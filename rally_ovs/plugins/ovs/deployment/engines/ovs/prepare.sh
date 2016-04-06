#!/bin/bash

set -e # exit on first error

OVS_USER=$1

echo "Prepare user $OVS_USER for ovs deployment"

useradd $OVS_USER -m || echo "User $OVS_USER is already exists" >&2
mkdir -m 700 /home/$OVS_USER/.ssh || true
cp /root/.ssh/authorized_keys /home/$OVS_USER/.ssh/ || true
chown -R $OVS_USER /home/$OVS_USER/.ssh || true

if [ `cat /etc/sudoers | grep $OVS_USER -c` = 0 ]; then
    echo "add $OVS_USER to /etc/sudoers"
    cat >> /etc/sudoers <<EOF
$OVS_USER ALL=(root) NOPASSWD:ALL
Defaults:$OVS_USER !requiretty
EOF

fi

echo "Prepare user $OVS_USER done"
