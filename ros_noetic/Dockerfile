# Imagem oficial do ros noetic
from osrf/ros:noetic-desktop-full 

# Realizando update, instalando pip e o git curl
RUN apt update
RUN apt-get install -y python3-pip
RUN apt install git curl -y

# Editor de texto
RUN apt install nano

# Instalando jupyterlab e nbdev
RUN pip install jupyterlab nbdev

# Instalando pytorch CPU only
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
