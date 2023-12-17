# Some problems and how to solve
Here are some of the problems I encountered when doing the tutorials and how I solved them

## 0º
Common problems you can have, may have to do with forgetting to source the setup.bash, or old versions of packages, running the followings may solve.

```bash
sudo apt-get update
sudo apt-get upgrade
source /opt/ros/rolling/setup.bash
```

## 1º
In this tutorial: https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html

When doing the build of the workspace may occur some problems with the command the tutorial use. 

```bash
colcon build --symlink-install
```
Using the following command worked for me, I have found the answer here: https://answers.ros.org/question/404536/colcon-build-fails-on-ros2-tutorials/
```bash
colcon build --symlink-installs --parallel-workers 2
```

## 2º
In this tutorial: https://docs.ros.org/en/humble/Tutorials/Intermediate/Tf2/Introduction-To-Tf2.html

To see the pdf, when using docker, you can either create a volume, or use the following command to copy the file from the container to your host machine. You have only to change the path and container name to your usage.

```bash
docker cp <containerName>:/path/to/the/file.pdf /path/where/to/save
```

## 3º
In this tutorial: https://moveit.picknik.ai/main/doc/tutorials/getting_started/getting_started.html

When building the workspace with the following command: 

```bash
colcon build --mixin release
```

In the tutorial they say It's where you may have difficulties depending on your ram memory, using docker you can run a container with more swap memory, in the run.bash script already have the memory parameters on docker run, but you can add more if necessary. You can also try using the args the tutorial recommends. And if the build is having problems completing, just keep repeating the same command until all everything build.
