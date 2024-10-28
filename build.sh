#!/bin/bash

# Step 1: 安装依赖
echo "Installing dependencies..."
sudo yum install -y libcurl-devel jsoncpp-devel libyaml-devel libzip-devel

# Step 2: 检查是否已克隆 ign-fuel-tools4 仓库
if [ ! -d "ign-fuel-tools4" ]; then
  echo "Cloning ign-fuel-tools4 repository..."
  git clone https://github.com/Sebastianhayashi/ign-fuel-tools4.git
fi

# Step 3: 进入 ign-fuel-tools4 项目目录
cd ign-fuel-tools4

# Step 4: 创建并进入 build 文件夹进行编译
echo "Starting build process for ign-fuel-tools4..."
mkdir -p build
cd build
cmake ..
make -j$(nproc)

# Step 5: 安装
echo "Installing ign-fuel-tools4..."
sudo make install

# Step 6: 验证安装是否成功
echo "Verifying ign-fuel-tools4 installation with pkg-config..."
if pkg-config --cflags --libs ignition-fuel_tools4; then
  echo "ign-fuel-tools4 successfully installed and located by pkg-config."
else
  echo "Error: pkg-config could not locate ign-fuel-tools4. Please check installation."
fi
