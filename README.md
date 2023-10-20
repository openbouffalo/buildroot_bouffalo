# Buildroot overlay for BL808 based boards

## Usage

```
git clone --recursive https://github.com/bouffalolab/buildroot_bouffalo.git
cd buildroot_bouffalo
export BR_BOUFFALO_OVERLAY_PATH=$(pwd)
cd buildroot
make BR2_EXTERNAL=$BR_BOUFFALO_OVERLAY_PATH bl808_nor_flash_defconfig
make
```

## Flashing Instructions

Download your prefered image above and extract the files.

- Get DevCube **1.8.3** from https://openbouffalo.org/static-assets/bldevcube/BouffaloLabDevCube-v1.8.3.zip (normal download location is http://dev.bouffalolab.com/download but 1.8.4 and later do not work, see #60)
- Connect BL808 board via serial port to your PC
- Set BL808 board to programming mode
    + Press BOOT button when reseting or applying power
    + Release BOOT button
- Run DevCube, select [BL808], and switch to [MCU] page
- Select the uart port and set baudrate with 2000000
    + UART TX is physical pin 1/GPIO 14.
    + UART RX is physical pin 2/GPIO 15.
- M0 Group[Group0] Image Addr [0x58000000] [PATH to m0_lowload_bl808_m0.bin]
- D0 Group[Group0] Image Addr [0x58100000] [PATH to d0_lowload_bl808_d0.bin]
- Click 'Create & Download' and wait until it's done
- Switch to [IOT] page
- Enable 'Single Download', set Address with 0x800000, choose [bl808-firmware.bin]
- Click 'Create & Download' again and wait until it's done
- flash the sdcard-pine64-*.img.xz to your SD card (you can use dd (after uncompressing) or https://github.com/balena-io/etcher)
- Serial Console access:
    + UART TX is physical pin 32/GPIO 16.
    + UART RX is physical pin 31/GPIO 17.
    + Baud 2000000.
- Enjoy!

## Current Status of Linux

Please refer to the projects tab for the status of drivers in development.

## Disucssions

Please use the github discussions for any questions or issues.
