# Testing with Melodic image
> Trying to install jupyterlab, nbdev and pytorch in Ros_Melodic_Desktopfull image.
## Steps
```
apt update
```
* Installing curl 
```
apt install git curl -y
```
* Installing pip
```
sudo apt install python-pip
```
* Installing jupyterlab
```
pip install jupyterlab
```
> Get a error Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-lpZZrf/Send2Trash/
* Upgrading pip to solve the problem
```
pip install --upgrade pip
```
> New error ERROR: Cannot uninstall 'subprocess32'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
* Solution
```
pip install --ignore-installed jupyterlab
```
* Executing jupyterlab
```
jupyter lab --no-browser --ip=0.0.0.0 --allow-root --ContentsManager.allow_hidden=True
```
> it works, but since we're using python 2.7, the pip installed a deprecated version.
* Installing nbdev
```
pip install nbdev
```
> Get the follow error ERROR: Could not find a version that satisfies the requirement nbdev (from versions: none)
> ERROR: No matching distribution found for nbdev

## Conclusion
Since ros_melodic is using python 2.7, and that bring a lot of limitations for us, we're moving to ros_noetic that comes with python 3.

