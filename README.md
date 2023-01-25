# Buildroot overlay for Bouffalo chips

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
- D0 Group[Group1] Image Addr [0x58000000] [PATH to d0_low_load_bl808_d0.bin]
- Click 'Create & Download' and wait until it's done
- Switch to [IOT] page
- Enable 'Single Download', set Address with 0xD2000, choose [PATH to whole_image_linux.bin]
- Click 'Create & Download' again and wait until it's done
- flash the sdcard-pine64-*.img.xz to your SD card (you can use dd (after uncompressing) or https://github.com/balena-io/etcher)
- Serial Console access:
    + UART TX is physical pin 32/GPIO 16.
    + UART RX is physical pin 31/GPIO 17.
    + Baud 2000000.
- Enjoy!
