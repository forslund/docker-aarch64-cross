#! /bin/bash

# Script for cross compiling U-boot for the H64


docker build -t aarch64-cross .

## Build arm-trusted firmware
if [ ! -d arm-trusted-firmware ]; then
	git clone https://github.com/ARM-software/arm-trusted-firmware
fi

cd arm-trusted-firmware
../aarch-run.sh "make CROSS_COMPILE=aarch64-linux-gnu- PLAT=sun50i_h6 DEBUG=1 all"
cd ..

## Build uboot
if [ ! -d u-boot ]; then
	git clone https://github.com/u-boot/u-boot
fi
cd u-boot

cp ../arm-trusted-firmware/build/sun50i_h6/debug/bl31.bin .
../aarch-run.sh "make pine_h64_defconfig"
../aarch-run.sh "CROSS_COMPILE=aarch64-linux-gnu- AARCH=aarch64 make"
