#! /bin/bash

set -e
set -o nounset

sudo apt-get install -y --no-install-recommends qemu-user-static binfmt-support \
update-binfmts --enable qemu-arm \
update-binfmts --display qemu-arm

WORK_DIR=${PWD}

sudo rm -rf copy_to_raspberry
mkdir copy_to_raspberry
cd copy_to_raspberry


git clone https://github.com/micro-ROS/ros2-performance -b microros_cc_tool
cd ros2-performance/cross-compiling
export TARGET=raspbian && export ROS2_DISTRO=dashing
bash build.sh
bash automatic_cross_compile.sh
sudo cp -rf $WORK_DIR/ros2-performance/ros2_cc_ws $WORK_DIR


cd $WORK_DIR
wget https://raw.githubusercontent.com/micro-ROS/micro-ROS-bridge_RPI/master/RPI_6lowpan/script.sh
chmod +wxr script.sh
sudo rm -rf ros2-performance
