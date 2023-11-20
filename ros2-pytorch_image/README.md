# Testing with Pytorch image
> Trying to install ROS 2 in pytorch/pytorch image.
## Steps
* Pulling the image
```
docker pull pytorch/pytorch
```
* Running the container
```
docker run -it --shm-size=32g -p 8888:8888 pytorch/pytorch
```
* Update
```
apt update
```
* Set locale
```
apt install locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale (UTF-8)
```
* Setup Sources
```
apt install software-properties-common
```
>(Geographic area -> 2 for south america; Time zone -> 135 for sao paulo)
```
add-apt-repository universe
apt update && apt install curl -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
```
* Ros installation
```
apt update
apt upgrade
```
> E: Unable to locate package ros-humble-desktop
## Conclusion
* From ROS documentation:
<br>"If you use something like conda, it is very likely that the interpreter will not match the system interpreter and will be incompatible with ROS 2 binaries"
<br>
<br>Since the pytorch/pytorch image uses conda, it causes issues when installing ROS 2, therefore we are moving to use a image without conda.
