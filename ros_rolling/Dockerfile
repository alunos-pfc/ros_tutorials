FROM osrf/ros:rolling-desktop-full

# Running essential commands
RUN sudo apt-get update
RUN sudo apt-get install build-essential
RUN sudo apt-get -y install vim

# Setting up the env
RUN echo >> .bashrc "source /opt/ros/humble/setup.bash