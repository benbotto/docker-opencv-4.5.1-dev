FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ARG UID=1000

WORKDIR /var/src/

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
  && cd /var/src/ \
  && rm -rf /var/src/opencv

RUN adduser \
    --disabled-password \
    --gecos '' \
    --uid $UID \
    opencv \
  && usermod -aG video opencv \
  && chown opencv:opencv /var/src

USER opencv
CMD /bin/bash
