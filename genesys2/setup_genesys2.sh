#!/usr/bin/bash

set -e

# Variables
CONFIG_FILE="genesys2_defconfig"
UBOOT_DIR=../

cd $UBOOT_DIR

# Check if config file exists
if [ ! -f "configs/$CONFIG_FILE" ]; then
    echo "Error: Config file configs/$CONFIG_FILE not found"
    exit 1
fi

# Extract DTS name from config file
DTS_NAME=$(grep "CONFIG_DEFAULT_DEVICE_TREE=" configs/$CONFIG_FILE | cut -d'"' -f2)
if [ -z "$DTS_NAME" ]; then
    echo "Error: Could not extract DTS name from $CONFIG_FILE"
    exit 1
fi

# Set build directory after DTS_NAME is extracted
BUILD_DIR="../../build/$DTS_NAME"

# Clean previous build
echo "Cleaning previous build..."
if ! make distclean; then
    echo "Error: Failed to clean previous build"
    exit 1
fi

# Configure U-Boot
echo "Configuring U-Boot with $CONFIG_FILE..."
if ! make CROSS_COMPILE=riscv64-linux-gnu- $CONFIG_FILE; then
    echo "Error: U-Boot configuration failed"
    exit 1
fi

# Build U-Boot
echo "Building U-Boot..."
if ! make CROSS_COMPILE=riscv64-linux-gnu- -j16; then
    echo "Error: U-Boot build failed"
    exit 1
fi

# Check if u-boot.bin was created
if [ ! -f "u-boot.bin" ]; then
    echo "Error: u-boot.bin not found after build"
    exit 1
fi

echo "U-Boot successfully built"

# Display DTS information
echo "Building for DTS: $DTS_NAME"

# Create build directory in root folder
echo "Creating build directory: $BUILD_DIR"
if ! mkdir -p $BUILD_DIR; then
    echo "Error: Failed to create build directory $BUILD_DIR"
    exit 1
fi

# Copy u-boot binary to build directory
echo "Copying u-boot.bin to $BUILD_DIR"
if ! cp u-boot.bin $BUILD_DIR/; then
    echo "Error: Failed to copy u-boot.bin to $BUILD_DIR"
    exit 1
fi

# Verify the binary was copied successfully
if [ ! -f "$BUILD_DIR/u-boot.bin" ]; then
    echo "Error: u-boot.bin not found in $BUILD_DIR after copy"
    exit 1
fi

echo "Build artifacts copied to $BUILD_DIR"
echo "Verification: u-boot.bin successfully exists in $BUILD_DIR"
echo "Build process completed successfully"
echo "Build for opensbi now can proceed."
