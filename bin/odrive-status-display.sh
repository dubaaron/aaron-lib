#!/bin/bash

# loop status display
while [[ 1 ]]; do
    odrive status
    odrive status --sync_requests
    odrive status --background
    echo "Downloads:"
    odrive status --downloads
    echo
    echo "Uploads:"
    odrive status --uploads
    echo
    odrive status --waiting
    odrive status --not_allowed
    odrive status --mounts
    sleep 1;
done
