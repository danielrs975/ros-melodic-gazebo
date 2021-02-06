#!/bin/bash
set -e

# setup gazebo environment
source "/usr/share/gazebo/setup.sh"
source "/opt/ros/melodic/setup.bash"

exec "$@"