FROM nvidia/cuda:12.2.0-devel-ubuntu20.04

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    build-essential \
    ffmpeg \
    python-opengl \
    g++ \
    htop \
    curl \
    git \
    tar \
    python3-pip \
    python3-numpy \
    python3-scipy \
    nano \
    unzip \
    vim \
    wget \
    swig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && conda init bash \
    . /root/.bashrc && \
    conda update conda && \
    conda install pip

COPY . .
RUN conda env create --file=environment.yml \
    && conda activate dreamer \
    && python -m pip install -e .


