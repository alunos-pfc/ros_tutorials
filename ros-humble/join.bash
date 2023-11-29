IMG="$1"

# Truncate last "/" in case using bash-complete for directory name
if [[ $IMG == */ ]]; then
  IMG=${IMG::-1}
fi
echo $IMG

# xhost + opens X view permissions to all hosts
# This allows other hosts to display graphics on the local screen
# the docker ps -aqf command gets the ID of the container that has the image specified as an ancestor (ancestor=${IMG}) # This assumes there is a container running with the provided image
xhost +
containerid=$(docker ps -aqf "ancestor=${IMG}")
docker exec --privileged -e DISPLAY=${DISPLAY} -e LINES=`tput lines` -it ${containerid} bash
xhost -