##### Base image
ARG BASE_IMAGE=ubuntu:jammy
FROM ${BASE_IMAGE}

# This avoids keyboard interaction when asked for geographic area
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y \
        curl \
        git \
 && rm -rf /var/lib/apt/lists/*

# Download and install Micromamba.
RUN curl -sL https://micro.mamba.pm/api/micromamba/linux-64/1.5.1 \
  | tar -xvj -C /usr/local bin/micromamba

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV ENV_NAME="base"
ENV MAMBA_ROOT_PREFIX="/opt/conda"
ENV MAMBA_EXE="/bin/micromamba"
ENV PATH="/bin/micromamba/bin:$PATH"

RUN micromamba create -n ros_env jupyter-ros jupyterlab ros-noetic-desktop -c conda-forge -c robostack -y
RUN micromamba shell init --shell=bash --prefix="$MAMBA_ROOT_PREFIX"
WORKDIR /root