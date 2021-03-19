#!/bin/bash

sudo xhost +local:root

docker run -it --rm \
  -v `pwd`:/var/src \
  -v/tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
  --user $(id -u):$(id -g) \
  avejidah/opencv-4.5.1-dev:latest \
  bash
