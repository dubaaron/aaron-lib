#!/bin/bash

echo "Starting odrive agent ..."
nohup ~/.odrive-agent/bin/odriveagent &

# Loop status display
while [[ 1 ]]; do
    odrive status;
    sleep 1;
done
