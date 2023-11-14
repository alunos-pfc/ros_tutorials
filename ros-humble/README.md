# Testing with ROS Humble image
Using the [osrf/ros:humble-desktop-full](https://hub.docker.com/r/osrf/ros/tags) image to create a ROS2 environment and testing it using the tutorial available at https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools/Introducing-Turtlesim/Introducing-Turtlesim.html.

This was tested in an Ubuntu 22.04 environment.

## 
## How to use

0 - Download the run.bash file to an empty folder and run the following command:

```bash
  chmod +x run.bash
```

1 - Download the Dockerfile and build it:

```bash
   docker build -t img-ros-humble .
```

2 - Run:

```bash
  ./run.bash img-ros-humble --no-nvidia
```

3 - Run:

```bash
  source /opt/ros/humble/setup.bash
```