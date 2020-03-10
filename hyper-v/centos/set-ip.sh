#!/usr/bin/env bash

echo 'Setting static IP address for Hyper-V...'

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
PREFIX=24
IPADDR=${1}
GATEWAY=10.0.0.1
DNS1=10.0.0.1
EOF