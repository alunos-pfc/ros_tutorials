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
* [Making a Mobile Robot #8 - Adding a Lidar](https://articulatedrobotics.xyz/mobile-robot-8-lidar/)
        ![Screenshot of lidar types](https://articulatedrobotics.xyz/media/assets/posts/mobile-robot/8-lidar/types2.png)
## Velodyne
Velodyne is a collection of ROS packages supporting Velodyne high definition 3D LIDARs.

* [Velodyne Lidar Company](https://velodynelidar.com/)
![Velodyne car](https://www.mundoconectado.com.br/wp-content/plugins/seox-image-magick/imagick_convert.php?width=1200&height=545&format=webp&quality=91&imagick=uploads.mundoconectado.com.br/2020/09/28175159/snesor_lidar.jpg)


* [Velodyne Package](https://github.com/ros-drivers/velodyne) 
    * [ROS2](https://index.ros.org/p/velodyne_driver/)
    * [ROS1](https://wiki.ros.org/velodyne) 
* [Youtube Video - ROS Simulation 3D Lidar | Velodyne | Point Cloud | Rviz Visualisation](https://www.youtube.com/watch?v=W-4Op5qljEc)
* [Quick start - Working with Point Cloud Library in ROS & Gazebo](https://medium.com/@tevhitkarsli/working-with-point-cloud-library-in-ros-gazebo-pcl-1-70ba44beb443)
![Velodyne lidar model and its point cloud data](https://miro.medium.com/v2/resize:fit:720/format:webp/1*d-Zrqe-LOmJRDPJ5Eq1YeA.png)

## Links 

* [3D Mapping with Graph SLAM using LiDAR in ROS2](https://medium.com/@rsasaki0109/3d-mapping-with-graph-slam-using-3d-lidar-in-ros2-12ea7140e548)
    * _ROS 2 package of 3D lidar slam using ndt/gicp registration and pose-optimization._
    * [Github](https://github.com/rsasaki0109/lidarslam_ros2)
* [ROS2 package for LDRobot lidar. Based on Nav2 Lifecycle nodes](https://github.com/Myzhar/ldrobot-lidar-ros2)
* [Simulating and Mapping 3D Environments with 2D Lidar in ROS](https://github.com/GutlapalliNikhil/3D-Mapping-Using-2D-LiDAR-ROS)
    * _Explores the world of 3D mapping using 2D Lidar in ROS, creating a simulated environment, collecting data with a 2D Lidar, and generating 3D maps using ROS and Gazebo._
    ![2d lidar with 3d](https://private-user-images.githubusercontent.com/33520288/261399014-69440bef-f2df-42ef-a26f-548203eebb40.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0MDA3NjMsIm5iZiI6MTcwMjQwMDQ2MywicGF0aCI6Ii8zMzUyMDI4OC8yNjEzOTkwMTQtNjk0NDBiZWYtZjJkZi00MmVmLWEyNmYtNTQ4MjAzZWViYjQwLmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTIlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEyVDE3MDEwM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRiNmE4MjFlNThhMGZjNTU4MDQ0MWEyMDVjNjVkODRiYTkzY2MyY2FhMjM0MDQ0ZmYwNTU4ZWZlMzVlZWJhMDQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.gLqdp3USOtk5-3UyEn1JN4_IJvbtc8Eo_giYlEq_l38)