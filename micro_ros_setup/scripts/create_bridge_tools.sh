#! /bin/bash

set -e
set -o nounset

mkdir copy_to_raspberry
cd copy_to_raspberry
export WORK_DIR="pwd"

git clone https://github.com/micro-ROS/ros2-performance -b cc_microros
cd ros2-performance 
git checkout e3cb7f8d61a1a10271050b3b2a476a25f1f9f802
cd cross-compiling
export TARGET=raspbian && export ROS2_DISTRO=dashing
bash build.sh
bash automatic_cross_compile.sh
sudo cp -r $WORK_DIR/ros2-performance/micro-ros_cc_ws $WORK_DIR


cd $WORK_DIR
wget https://raw.githubusercontent.com/micro-ROS/micro-ROS-bridge_RPI/master/RPI_6lowpan/script.sh
chmod +wxr script.sh
sudo rm -rf ros2-performance
