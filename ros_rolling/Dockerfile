FROM osrf/ros:rolling-desktop-full

# Running essential commands
RUN sudo apt-get update
RUN sudo apt install build-essential
RUN sudo apt install vim

# Setting up the env
RUN echo >> .bashrc "source /opt/ros/humble/setup.bash"