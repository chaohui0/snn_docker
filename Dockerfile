FROM ubuntu:20.04

RUN apt update
RUN apt install -y gcc-10 g++-10 
# 安装miniconda
COPY Miniconda3-py39_4.12.0-Linux-x86_64.sh .
RUN /bin/bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b && rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
ENV PATH=/root/miniconda3/bin:${PATH}

COPY requirement.txt .
RUN pip install -r requirement.txt
RUN pip install h5py matplotlib numpy pyside2
RUN apt-get install -y cmake
RUN apt-get install -y vim 
RUN apt-get install -y python3-pip
RUN apt-get install -y libhdf5-dev
RUN apt-get install -y libxcb-xinerama0
RUN apt install python3-h5py

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100

RUN conda install -y libstdcxx-ng
ENV LD_LIBRARY_PATH=/root/miniconda3/pkgs/libstdcxx-ng-11.2.0-h1234567_1/lib/:${LD_LIBRARY_PATH}
#RUN apt-get install -y git-all
