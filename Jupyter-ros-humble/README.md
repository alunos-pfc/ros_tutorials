# Jupyter-ROS Docker Image

This Docker image provides a Jupyter environment with ROS (Robot Operating System) capabilities, making it convenient for roboticists and developers working in ROS.

## Building the Image

To build the Docker image, run the following command:

```bash
docker build -t jupyter-ros-humble .
```

## Running the Image

To start the Jupyter server, use the following command:

```bash
docker run -it -p 8888:8888 jupyter-ros-humble
```

## Activating Micromamba Environment

After starting the container, activate the Micromamba environment by running:

```bash
micromamba activate ros_env
```

## Installing Jupyros

Inside the activated environment, install Jupyros using pip:

```bash
pip install --pre jupyros==0.7.0a0
```

## Testing with TurtleSim

Clone this repository and open the TurtleSim.ipynb notebook to test the ROS integration. Use the following commands:

```
git clone https://github.com/alunos-pfc/ros_tutorials.git
cd ros_tutorials/Jupyter-ros-humble
```


## Starting Jupyter Lab

Once Jupyros is installed and the repository is cloned, start Jupyter Lab with the following command:

```bash
jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root --ContentsManager.allow_hidden=True
```

Access Jupyter Lab by navigating to the provided link in your web browser.