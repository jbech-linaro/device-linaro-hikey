SCRIPT=../../../build/tools/fat16copy.py 
AOSP_OUT=/mnt/sshd/devel/optee_projects/aosp/out/target/product/hikey
KERNEL_IMAGE=$AOSP_OUT/kernel_obj/arch/arm64/boot/Image
KERNEL_DTB=$AOSP_OUT/kernel_obj/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb
DEVICE=`pwd`
CLEAN_IMG=$DEVICE/installer/hikey/boot_fat.uefi.img
IMG=$DEVICE/boot_fat.uefi.img

cp -f $KERNEL_IMAGE $DEVICE/kernel
cp -f $CLEAN_IMG .

$SCRIPT $IMG $DEVICE/kernel
$SCRIPT $IMG $KERNEL_DTB
$SCRIPT $IMG $DEVICE/bootloader/*
$SCRIPT $IMG $AOSP_OUT/ramdisk.img
