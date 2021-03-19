FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/

RUN apt-get update \
  && apt-get install -y -qq \
    g++ \
    cmake \
    git \
    pkg-config \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libgtk2.0-dev \
    libcanberra-gtk-module \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/opencv/opencv.git \
  && cd opencv \
  && git checkout 4.5.1 \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make -j4 \
  && make install \
  && cd /var/ \
  && rm -rf /var/opencv
