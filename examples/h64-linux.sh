#! /bin/bash

#docker build -t aarch64-cross .

if [ ! -d linux ]; then
	git clone https://gitlab.com/pine64-org/linux --branch pine64-kernel --depth=1
fi

cd linux
rm -rf debs
mkdir -p debs

../aarch-run.sh "make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 KBUILD_DEBARCH=arm64 LOCALVERSION=-pine64 pine64_defconfig"
../aarch-run.sh "make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 KBUILD_DEBARCH=arm64 LOCALVERSION=-pine64 -j$(nproc) deb-pkg && mv ../*.deb ./debs/"

#ls ./debs

cd ..

#rm -rf mali-midgard
if [ ! -d "mali-midgard" ]; then
	git clone https://github.com/jernejsk/mali-midgard.git --branch aw_plat --depth=1
fi


./aarch-run.sh "cd mali-midgard/driver/product/kernel/drivers/gpu/arm/midgard/ && \
  make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 KBUILD_DEBARCH=arm64 \
    LOCALVERSION=-pine64 CONFIG_MALI_MIDGARD=m CONFIG_MALI_PLATFORM_NAME=sunxi \
    CONFIG_MALI_EXPERT=y CONFIG_MALI_BACKEND=gpu CONFIG_MALI_PLATFORM_DEVICETREE=y \
    KDIR=../../../../../../../../linux"


echo "Building archive..."
mkdir -p archive
cp mali-midgard/driver/product/kernel/drivers/gpu/arm/midgard/mali_kbase.ko archive/
cp linux/debs/*.deb archive/
cd archive
zip archive.zip *.deb *.ko
mv archive.zip ../
rm -rf archive
