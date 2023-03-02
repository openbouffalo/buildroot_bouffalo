echo "Loading Kernel from SD card"
mmc rescan
load mmc 0:2 0x50200000 Image
echo "This kernel is configure for Sipeed M1S board"
echo "please see /root/readme.txt to learn how to switch to other boards"
load mmc 0:2 0x51ff8000 bl808-sipeed-m1s.dtb
booti 0x50200000 - 0x51ff8000
