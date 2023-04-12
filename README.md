# Buildroot overlay for BL808 based boards

## Usage

```
mkdir buildroot_bouffalo && cd buildroot_bouffalo
git clone https://github.com/buildroot/buildroot
git clone https://github.com/openbouffalo/buildroot_bouffalo
export BR_BOUFFALO_OVERLAY_PATH=$(pwd)/buildroot_bouffalo
cd buildroot
make BR2_EXTERNAL=$BR_BOUFFALO_OVERLAY_PATH pine64_ox64_defconfig
make
```

## Prebuilt images

Prebuilt images are available on the releases page (for tested images) or development images are available via the github actions page

Two images are currently build - A minimal image - `sdcard-pine64_0x64_defconfig` and a more complete image - `sdcard-pine64_0x64_full_defconfig`

The SD card images are configured with a 1Gb Swap Partition, and will resize the rootfs partition on first boot to the full size of the SD card.

Inside the downloads you will find the following files:
* m0_lowload_bl808_m0.bin - This firmware runs on M0 and forwards interupts to the D0 for several peripherals
* d0_lowload_bl808_d0.bin - This is a very basic bootloader that loads opensbi, the kernel and dts files into ram
* bl808-firmware.bin - A image containing OpenSBI, Uboot and uboot dtb files. 
* sdcard-*.tar.xz - A tarball containing the rootfs for the image to be flashed to the SD card

### Development images
Latest Development Build Result:
[![Build](https://github.com/openbouffalo/buildroot_bouffalo/actions/workflows/buildroot.yml/badge.svg)](https://github.com/openbouffalo/buildroot_bouffalo/actions/workflows/buildroot.yml)

### Released images

Released Images are [Here](https://github.com/openbouffalo/buildroot_bouffalo/releases/latest)

## Flashing Instructions

Download your prefered image above and extract the files.

- Get the latest version of DevCube from http://dev.bouffalolab.com/download
- Connect BL808 board via serial port to your PC
- Set BL808 board to programming mode
    + Press BOOT button when reseting or applying power
    + Release BOOT button
- Run DevCube, select [BL808], and switch to [MCU] page
- Select the uart port and set baudrate with 2000000
    + UART TX is physical pin 1/GPIO 14.
    + UART RX is physical pin 2/GPIO 15.
- M0 Group[Group0] Image Addr [0x58000000] [PATH to m0_low_load_bl808_m0.bin]
- D0 Group[Group0] Image Addr [0x58100000] [PATH to d0_low_load_bl808_d0.bin]
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

## Compiling Applications for BL808 based boards

Buildroot provides a "SDK" for the boards. This is a tarball containing the cross compiler and sysroot for the target board. This can be used to compile applications for the board. Please refer to https://github.com/openbouffalo/buildroot_bouffalo/wiki/Building-Programs-outside-of-buildroot for basic instructions (or consult the [buildroot documentation](https://buildroot.org/downloads/manual/using-buildroot-toolchain.txt))

## Current Status of Linux

Please refer to the projects tab for the status of drivers in development.

## Disucssions

Please use the github discussions for any questions or issues.
