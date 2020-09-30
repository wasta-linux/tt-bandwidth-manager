#!/bin/bash

# Ensure proper deconfiguration of systemd service.
echo "Stopping tt-bandwidth-manager.service..."
systemctl stop tt-bandwidth-manager.service
systemctl disable tt-bandwidth-manager.service
systemctl daemon-reload
exit 0
