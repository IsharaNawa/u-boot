#/usr/bin/bash

set -e

UBOOT_DIR=~/Research/repos/u-boot

cd $UBOOT_DIR

make distclean
# make CROSS_COMPILE=riscv64-linux-gnu- genesys2_defconfig
make CROSS_COMPILE=riscv64-linux-gnu- Rocket90MHZ_defconfig
make CROSS_COMPILE=riscv64-linux-gnu- -j16
