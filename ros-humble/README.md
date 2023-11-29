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

4 - If you need to open another terminal, run:
```bash
    chmod +x join.bash
  ./join.bash img-ros-humble --no-nvidia
```


## Tutorials

* [ ROS 2 Documentation: Humble](https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools.html)
* [The Robotics Back-End](https://roboticsbackend.com/category/ros2/)
    * [ROS2 Nav2 Tutorial](https://roboticsbackend.com/ros2-nav2-tutorial/)
        - At the beggining of the tutorial, run: ```nano ~/.bashrc```, insert the following lines, save, and then run ```. ~/.bashrc```:
        ```
            export TURTLEBOT3_MODEL=waffle
            source /opt/ros/humble/setup.bash
        ```
  

        ![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://emanual.robotis.com/assets/images/platform/turtlebot3/ros2/gazebo_world.png)

