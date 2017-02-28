ifneq ($(filter hikey%, $(TARGET_DEVICE)),)

ifeq ($(TARGET_BOOTIMAGE_USE_FAT), true)
$(PRODUCT_OUT)/boot_fat.uefi.img: $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RAMDISK_TARGET) $(PRODUCT_OUT)/hi6220-hikey.dtb
# $@ is referring to $(PRODUCT_OUT)/boot_fat.uefi.img
	#dd if=/dev/zero of=$@ bs=512 count=98304
	#mkfs.fat -n "boot" $@
	# Copy the clean boot_fat.uefi.img. The reason for having a
	# pre-generated boot_fat.uefi.img here is because on newer versions of
	# mkfs.fat (4.0), then it seems impossible to set the "Reserved vectors"
	# to "1". It defaults to 4 reserved sectors and it can go higher but not
	# lower (-R flag). I could be a bug in the new mkfs.fat tool. So, the
	# pre-build image here some from the mkfs.fat 3.0.26 (2014-03-07), which
	# gives the correct number of reserved sectors. This replace the "dd"
	# and the "mkfs.fat" steps previously done here.
	#
	# Always start out with a fresh copy
	cp -f device/linaro/hikey/installer/hikey/boot_fat.uefi.img $(PRODUCT_OUT)/
	$(FAT16COPY) $@ $(PRODUCT_OUT)/kernel
	$(FAT16COPY) $@ $(PRODUCT_OUT)/hi6220-hikey.dtb
	$(FAT16COPY) $@ device/linaro/hikey/bootloader/*
	$(FAT16COPY) $@ $(PRODUCT_OUT)/ramdisk.img

droidcore: $(PRODUCT_OUT)/boot_fat.uefi.img
endif

endif
