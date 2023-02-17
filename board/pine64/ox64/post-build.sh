#!/bin/sh
echo "Compressing Kernel Image"
lz4 -9 -f $BINARIES_DIR/Image $BINARIES_DIR/Image.lz4
cd $BINARIES_DIR
echo "Creating OpenSBI/DTB/Kernel Image"
$BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/mergebin.py -o pine64-ox64-firmware.bin -k Image.lz4 -d bl808-pine64-ox64.dtb -s fw_jump.bin
$BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/mergebin.py -o sispeed-m1s-firmware.bin -k Image.lz4 -d bl808-sipeed-m1s.dtb -s fw_jump.bin
echo "Creating Filesystem Image"
$BASE_DIR/../support/scripts/genimage.sh -c $BR2_EXTERNAL_BOUFFALO_BR_PATH/board/pine64/ox64/genimage.cfg
echo "Completed - Images are at $BINARIES_DIR"