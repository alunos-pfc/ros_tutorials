#!/usr/bin/env bash

#
# Copyright (C) 2023 Open Source Robotics Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

# Runs a docker container with the image created by build.bash
# Requires:
#   docker
#   an X server
# Optional:
#   nvidia-docker
#   A joystick mounted to /dev/input/js0 or /dev/input/js1

if [ $# -lt 1 ]         # verify if the number of arguments passed to the script is less than 1
then
    echo "Usage: $0 <docker image> [<dir with workspace> ...]"  # prints a message saying that is necessary to provide at least one argument
    exit 1                                                      # the docker image, and optionally a directory for the workspace
fi

# Default to NVIDIA
# This verifies whether the dpkg command is available on the system
# dpkg is a command tool offered by the Linux command line to manage Debian systems packages
# Note that on all non-Debian/non-Ubuntu platforms, dpkg won't exist so they'll always choose
# --runtime=nvidia.  If you are running one of those platforms and --runtime=nvidia doesn't work
# for you, change the else statement.
# Command -v dpkg returns the path to the dpkg executable. The -x test verifies that the file exists and is executable.

if [[ -x "$(command -v dpkg)" ]] && dpkg --compare-versions "$(docker version --format '{{.Server.Version}}')" gt "19.3"; then
  DOCKER_OPTS="--gpus=all"
else
  DOCKER_OPTS="--runtime=nvidia"
fi

# Parse and remove args
PARAMS=""
while (( "$#" )); do
  case "$1" in
    --no-nvidia)
        DOCKER_OPTS=""    #If the argument is --no-nvidia, then DOCKER_OPTS is set to an empty string, so a GPU will not be used
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place 
eval set -- "$PARAMS"

# Works for image names containing "/" character, but cannot run from another directory
# Assigns the first argument (the Docker image name) to the IMG variable
IMG="$1"
#The next line, if uncommented, would use the basename command to extract just the filename from the Docker image, removing any paths
#IMG=$(basename $1)                 
# Truncate last "/" in case using bash-complete for directory name, to ensure the image name is formatted correctly
if [[ $IMG == */ ]]; then
  IMG=${IMG::-1}
fi
echo $IMG

ARGS=("$@")                   #Creates an array called ARGS containing all the original positional arguments
WORKSPACES=("${ARGS[@]:1}")   #Creates an array called WORKSPACES containing all positional arguments except the first one (the Docker image)

# Make sure processes in the container can connect to the x server
# Necessary so gazebo can create a context for OpenGL rendering (even headless)
# xauth_list gets the X authorization list for the current display, the $DISPLAY command returns a list of X authorizations, 
# and sed is used to replace the first four characters of each line with "ffff"
# This is done as a workaround for a specific issue on some systems when obtaining the authorization list

XAUTH=/tmp/.docker.xauth                                             # Sets the path to the X authorization file
if [ ! -f $XAUTH ]                                                   # Checks if the authorization file X does not exist
then
    xauth_list=$(xauth nlist $DISPLAY | sed -e 's/^..../ffff/') 
    if [ ! -z "$xauth_list" ]                                        # Checks if the X authorization list is not empty
    then
        touch $XAUTH                                                 # Creates the X authorization file if it doesn't exist
        echo $xauth_list | xauth -f $XAUTH nmerge -                  # Adds the previously obtained X authorizations to the newly created X authorization file
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH                                                 # Ensures that the X authorization file is readable by all users on the system
fi

# Share your vim settings.
# Verifies if the Vim configuration file (~/.vimrc) exists on the host machine
# If the file exists, it adds a Docker volume option (-v) to include this Vim configuration file in a Docker container, allowing the container
# to use the same Vim settings as the host machine, then it appends this volume option to the variable ($DOCKER_OPTS)
# The :ro at the end specifies that the volume should be mounted read-only in the container
# This is ensuring consistent Vim settings between the host and the Docker container when running a development environment
VIMRC=~/.vimrc
if [ -f $VIMRC ]
then
  DOCKER_OPTS="$DOCKER_OPTS -v $VIMRC:/home/developer/.vimrc:ro"
fi

# Share your custom terminal setup commands
GITCONFIG=~/.gitconfig                                                 # Defines the path to the Git configuration file on the host machine
DOCKER_OPTS="$DOCKER_OPTS -v $GITCONFIG:/home/developer/.gitconfig:ro" # Specifies that the Git configuration file on the host should be mounted into the container at the path

# The next lines are looping through a list of workspace directories
# For each workspace, it determines whether it should be categorized as "Workspace" or "Other" based on the existence of a "src" subdirectory
# It then adds Docker volume options to DOCKER_OPTS accordingly, allowing the specified directories to be mounted into the Docker container at specific paths

for WS_DIR in ${WORKSPACES[@]}
do
  WS_DIRNAME=$(basename $WS_DIR)
  if [ ! -d $WS_DIR/src ]
  then
    echo "Other! $WS_DIR"
    DOCKER_OPTS="$DOCKER_OPTS -v $WS_DIR:/home/developer/other/$WS_DIRNAME"
  else
    echo "Workspace! $WS_DIR"
    DOCKER_OPTS="$DOCKER_OPTS -v $WS_DIR:/home/developer/workspaces/$WS_DIRNAME"
  fi
done

# Synchronize ROS 2 and Gazebo transport environment variables with the host
# Default to isolated communication
# The next lines are setting up environment variables related to ROS 2 and Gazebo
# and it incorporates these environment variables into the Docker options for use when running a Docker container
ROS_ENVS=(
  "ROS_DOMAIN_ID=${ROS_DOMAIN_ID:-"0"}"
  "ROS_LOCALHOST_ONLY=${ROS_LOCALHOST_ONLY:-"1"}"
)
GZ_ENVS=(
  "GZ_IP=${GZ_IP:-"127.0.0.1"}"
  "GZ_RELAY=${GZ_RELAY:-"127.0.0.1"}"
)
DOCKER_OPTS="${DOCKER_OPTS} ${ROS_ENVS[*]/#/"-e "} ${GZ_ENVS[*]/#/"-e "}"

# Mount extra volumes if needed.
# E.g.:
# -v "/opt/sublime_text:/opt/sublime_text" \

# Relax X server permissions so that local X connections work; this is necessary
# when running under XWayland
xhost + local:

# --ipc=host and --network=host are needed for no-NVIDIA Dockerfile to work

# X11 is the standard protocol for graphical user interfaces in Unix-like operating systems
# The X server listens for connections from X clients, and these connections are typically established through a Unix socket
# /tmp/.X11-unix is the default directory where X11 Unix sockets are created
# The next lines mounts the host machine's /tmp/.X11-unix directory into the same directory within the Docker container
# By doing this, the X11 Unix socket on the host becomes accessible to the Docker container
# For graphical applications in the Docker container to display on the host's X server, they need access to the X11 Unix socket

# the -v "/dev/input:/dev/input" option allows the Docker container to access input devices on the host, 
# enabling interactions with keyboards, mice, and other input peripherals
# The --privileged flag grants extended privileges to the container, potentially necessary for certain low-level operations, 
# but it should be used judiciously due to security implications

# DISPLAY passes the DISPLAY environment variable to the container, allowing it to connect to the X server

docker run -it \
  -e DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "$XAUTH:$XAUTH" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev/input:/dev/input" \
  --privileged \
  --rm \
  --security-opt seccomp=unconfined \
  --ipc=host \
  --network=host \
  $DOCKER_OPTS \
  $IMG

# Put X server permissions back to what they were.  If this script is killed
# uncleanly, then this may not run.
xhost - local:
