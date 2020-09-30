#!/bin/bash

# Set default config if none already present.
dir=/usr/share/tt-bandwidth-manager
config=tt-config.yaml
if [[ ! -e /etc/$config ]]; then
    cp $dir/tt-default-config.yaml /etc/$config
fi

# Ensure proper configuration of systemd service.
echo "Starting tt-bandwidth-manager.service..."
systemctl daemon-reload
systemctl enable tt-bandwidth-manager.service
systemctl restart tt-bandwidth-manager.service
exit 0
