#! /bin/bash

set -e
set -o nounset

# Install Qemu on the host PC
sudo apt-get install -y --no-install-recommends qemu-user-static binfmt-support 
update-binfmts --enable qemu-arm 
update-binfmts --display qemu-arm

ROOT_DIR=${PWD}

# Delete previous cross-compilation work space and create a new empty
sudo rm -rf $ROOT_DIR/copy_to_raspberry
mkdir $ROOT_DIR/copy_to_raspberry
cd $ROOT_DIR/copy_to_raspberry
WORK_DIR=${PWD}

# Download the cross-compilation tool
git clone https://github.com/micro-ROS/ros2-performance -b microros_cc_tool
cd ros2-performance/cross-compiling

# Set the architecture target and the ROS2 distro which base on.
export TARGET=raspbian && export ROS2_DISTRO=dashing

# Start the cross-compile tools 
bash build.sh
bash automatic_cross_compile.sh

# Copy the result of the cross-compilation work
sudo cp -rf $WORK_DIR/ros2-performance/micro-ros_cc_ws $WORK_DIR

# Download the 6LowPan set-up script.
cd $WORK_DIR
wget https://raw.githubusercontent.com/micro-ROS/micro-ROS-bridge_RPI/master/RPI_6lowpan/script.sh
chmod +wxr script.sh

# Delete the previous workspace
sudo rm -rf $WORK_DIR/ros2-performance
