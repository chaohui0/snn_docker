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
RUN apt-get install -y cmake vim libhdf5-dev libxcb-xinerama0 
RUN sh -c '/bin/echo -e "70" |/bin/echo -e "6"  | /bin/echo -e "y" | apt-get install python3-h5py'

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100

RUN conda install -y libstdcxx-ng
ENV LD_LIBRARY_PATH=/root/miniconda3/pkgs/libstdcxx-ng-11.2.0-h1234567_1/lib/:${LD_LIBRARY_PATH}

RUN apt-get install ffmpeg libsm6 libxext6 libgl1 -y

RUN ln -s /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so /usr/lib/x86_64-linux-gnu/libhdf5.so.200 && ln -s /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_cpp.so /usr/lib/x86_64-linux-gnu/libhdf5_cpp.so.200

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN export LANG=C.UTF-8
