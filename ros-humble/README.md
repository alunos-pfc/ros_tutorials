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

* [ROS2 Documentation: Humble](https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools.html)
* [NAV2 Documentation: Getting Started](https://navigation.ros.org/getting_started/index.html)
* [The Robotics Back-End](https://roboticsbackend.com/category/ros2/)
    * [ROS2 Nav2 Tutorial](https://roboticsbackend.com/ros2-nav2-tutorial/)
        - At the beggining of the tutorial, run: ```nano ~/.bashrc```, insert the following lines, save, and then run ```. ~/.bashrc```:
        ```
            export TURTLEBOT3_MODEL=waffle
            source /opt/ros/humble/setup.bash
        ```
  

        ![Screenshot of turtlebot in gazebo](https://emanual.robotis.com/assets/images/platform/turtlebot3/ros2/gazebo_world.png)

* [The Ultimate Guide to the ROS 2 Navigation Stack](https://automaticaddison.com/the-ultimate-guide-to-the-ros-2-navigation-stack/)
    * This tutorial uses the Foxy distribution, so to execute it with this image, change any part of the command that mentions 'foxy' to 'humble'
    * You can use the previous Nav2 Tutorial to install the ROS 2 Navigation Stack
    * [Set Up the Odometry for a Simulated Mobile Robot in ROS 2](https://automaticaddison.com/set-up-the-odometry-for-a-simulated-mobile-robot-in-ros-2/)
        * _In robotics, odometry is about using data from sensors to estimate the change in a robot’s position, orientation, and velocity over time relative to some point (e.g. x=0, y=0, z=0). Odometry information is normally obtained from sensors such as wheel encoders, IMU (Inertial measurement unit), and LIDAR._


        * To get the meshes files, run inside the meshes folder:
            ```
            gdown --id 1rl9A7UhyuDfGtPsGlp52n012mpnlnliy  
            gdown --id 1bzrmsDwnFSPy54Y3CwYKs0eV3jBnRcGE
            gdown --id 1ylvQZUJA0RRy8zvKuN1pZSBACzXbEKFg
            gdown --id 1resa_Mmvd3A1NR1fCBCnWprFa5MpTU2I
            gdown --id 1h1BK-nvOmBVJRuJFSTaW8c2Ir0dUeCeO
            gdown --id 1QObAigAwryBnLrgki4KuOIer5ybfe-rI
            ```
    * [Set Up LIDAR for a Simulated Mobile Robot in ROS 2](https://automaticaddison.com/set-up-lidar-for-a-simulated-mobile-robot-in-ros-2/)
                ![Screenshot of robot with lidar](https://automaticaddison.com/wp-content/uploads/2021/09/5-output-for-gazebo-1.jpg)
## Links 

* [3D Mapping with Graph SLAM using LiDAR in ROS2](https://medium.com/@rsasaki0109/3d-mapping-with-graph-slam-using-3d-lidar-in-ros2-12ea7140e548)
    * _ROS 2 package of 3D lidar slam using ndt/gicp registration and pose-optimization_
    * [Github](https://github.com/rsasaki0109/lidarslam_ros2)
* [ROS2 package for LDRobot lidar. Based on Nav2 Lifecycle nodes](https://github.com/Myzhar/ldrobot-lidar-ros2)