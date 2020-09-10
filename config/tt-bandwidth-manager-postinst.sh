#!/bin/bash

# Install TrafficToll python package.
echo "Installing traffictoll python3 package..."
pip3 install --system --ignore-installed traffictoll

# Ensure proper configuration of systemd service.
echo "Starting tt-bandwidth-manager.service..."
systemctl daemon-reload
systemctl enable tt-bandwidth-manager.service
systemctl start tt-bandwidth-manager.service
