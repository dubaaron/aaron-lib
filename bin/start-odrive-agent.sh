#!/bin/bash

echo "Starting odrive agent ..."
# todo: make sure this doesn't accidentally spawn a whole crapload of odrive agents?
# OR: separate status display loop into separate script, and just run that instead, so it can be easily run separately.
nohup ~/.odrive-agent/bin/odriveagent &

# Loop status display
while [[ 1 ]]; do
    odrive status;
    sleep 1;
done
