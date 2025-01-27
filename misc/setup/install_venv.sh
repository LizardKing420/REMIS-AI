#!bin/bash

#pip
sudo apt-get -y update
sudo apt install -y pip
pip install --upgrade pip

# install libcamera
mkdir -p ~/Downloads/
git clone https://git.libcamera.org/libcamera/libcamera.git ~/Downloads/
cd ~/Downloads/libcamera/
meson setup build
ninja -C build install

#install opencv: (Kamera-Flip)
pip install opencv-python

#TODO: add other packs