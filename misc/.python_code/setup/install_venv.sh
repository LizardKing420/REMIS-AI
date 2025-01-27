#!bin/bash

# isnstall libcamera
git clone https://git.libcamera.org/libcamera/libcamera.git
cd libcamera
meson setup build
ninja -C build install

#install opencv: (Für Kamera-Flip)
pip install opencv-python
