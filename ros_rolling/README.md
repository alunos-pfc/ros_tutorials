# Testing with ROS Rolling image
Using the [osrf/ros:rolling-desktop-full](https://hub.docker.com/r/osrf/ros/tags) image to create a ROS2 environment and testing it using the tutorial available at https://docs.ros.org/en/rolling/index.html

---
## How to use

0 - clone this repository, and change to this directory (will be clonnig to HOME dir):

```bash
git clone https://github.com/alunos-pfc/ros_tutorials.git  ~/
cd ~/ros_tutorials/ros_rolling
```

1 - Build the docker running the command:

```bash
docker build -t img-ros-rolling .
```

2 - Run:

```bash
./run.bash img-ros-humble
```

3 - If you need to open another terminal, run:
```bash
./join.bash img-ros-rolling
```


- Obs: if you want to run multiple container, for join.bash to work you have to open the join.bash scrip and change the container id for the container that you want to join, where to change is explained on the file, in the final lines.

## Tutorials

* [ROS2 Documentation: Rolling](https://docs.ros.org/en/rolling/Tutorials.html)

* [ROS2 Navigation Stack](https://www.youtube.com/playlist?list=PLBbhfIdh4NdhOhVq0VcuCvdqOn6zdmQ3b)