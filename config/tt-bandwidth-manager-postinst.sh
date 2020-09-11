#!/bin/bash

# Install TrafficToll python package.
echo "Installing traffictoll python3 package..."
pip3 install --system --ignore-installed traffictoll

# Set default config if none already present.
d=/usr/share/tt-bandwidth-manager
config=tt-config.yaml
if [[ ! -e $d/$config ]]; then
    cp $d/tt-default-config.yaml $d/$config
fi

# Ensure proper configuration of systemd service.
echo "Starting tt-bandwidth-manager.service..."
systemctl daemon-reload
systemctl enable tt-bandwidth-manager.service
systemctl start tt-bandwidth-manager.service
