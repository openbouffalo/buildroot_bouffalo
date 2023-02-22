echo "Loading Kernel from SD card"
mmc rescan
load mmc 0:2 0x50200000 Image
echo "This kernel is configure for Pine64 ox64 board"
echo "please see /root/readme.txt to learn how to switch to other boards"
load mmc 0:2 0x51ff8000 bl808-pine64-ox64.dtb
booti 0x50200000 - 0x51ff8000
