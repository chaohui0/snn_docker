FROM ubuntu:20.04

RUN apt update
# 安装miniconda
COPY Miniconda3-py39_4.12.0-Linux-x86_64.sh .
RUN /bin/bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b && rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
ENV PATH=/root/miniconda3/bin:${PATH}

RUN apt-get install g++-10 python3-pip libhdf5-dev libxcb-xinerama0 cmake git-all
RUN pip install h5py matplotlib numpy pyside2
RUN pip install -r requirement.txt