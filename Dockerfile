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

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

ENV PATH=/root/miniconda/bin:$PATH

COPY . .

RUN /root/miniconda/bin/conda install -y conda-build \
    && /root//miniconda/bin/conda env create --file=environment.yml \
    && /root//miniconda/bin/conda clean -ya

ENV CONDA_DEFAULT_ENV=dreamer
ENV CONDA_PREFIX=/root/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

RUN python -m pip install -e .


