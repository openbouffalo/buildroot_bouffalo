#!/bin/sh
#echo "Compressing Kernel Image"
#lz4 -9 -f $BINARIES_DIR/Image $BINARIES_DIR/Image.lz4
echo "Compressing UBoot Image"
lz4 -9 -f $BINARIES_DIR/u-boot.bin $BINARIES_DIR/u-boot.bin.lz4
cd $BINARIES_DIR
echo "Creating OpenSBI/DTB/Kernel Image"
$BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/mergebin.py -o pine64-ox64-firmware.bin -k u-boot.bin.lz4 -d u-boot.dtb -s fw_jump.bin
$BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/mergebin.py -o sispeed-m1s-firmware.bin -k u-boot.bin.lz4 -d u-boot.dtb -s fw_jump.bin
echo "Copying Boot Script"
$BR2_HOST_DIR/bin/mkimage -C none -A riscv -T script -d $BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/boot-m1s.cmd $BINARIES_DIR/boot-m1s.scr
$BR2_HOST_DIR/bin/mkimage -C none -A riscv -T script -d $BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/boot-pine64.cmd $BINARIES_DIR/boot-pine64.scr
cp $BINARIES_DIR/boot-pine64.scr $BINARIES_DIR/boot.scr
cp $BINARIES_DIR/*.scr $TARGET_DIR/boot/
cp $BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/*.cmd $TARGET_DIR/boot/
echo "Creating Filesystem Image"
$BASE_DIR/../support/scripts/genimage.sh -c $BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/genimage.cfg
echo "Completed - Images are at $BINARIES_DIR"