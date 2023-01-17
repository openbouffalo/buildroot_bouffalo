#!/bin/python3
# Description: Merge the Kernel, DTB, and OpenSBI into a single binary
# From @BBBSnowball 
import struct
from math import inf

kB = 1024
MB = 1024*1024

def format_size(x):
    if (x % MB) == 0:
        return "%d MB" % (x/MB)
    elif (x % kB) == 0:
        return "%d kB" % (x/kB)
    else:
        return "%d bytes" % x

class FlashRegion(object):
    def __init__(self, from_file, flash_offset, load_address, max_size=inf):
        self.from_file = from_file
        self.flash_offset = flash_offset
        self.load_address = load_address
        self.max_size = max_size

    def read(self):
        if self.from_file is None:
            self.data = b""
        else:
            with open(self.from_file, 'rb') as f:
                self.data = f.read()

class FlashRegions(object):
    def __init__(self, flash_size):
        self.flash_size = flash_size
        self.regions = {}

    def add(self, name, *args, **kwargs):
        v = FlashRegion(*args, **kwargs)
        self.regions[name] = v
        setattr(self, name, v)

    def read(self):
        for k,v in self.regions.items():
            v.read()

    def check(self):
        # reduce max_size based on where the next item starts in flash
        next_start = self.flash_size
        for region in sorted(self.regions.values(), key=lambda x: x.flash_offset, reverse=True):
            #print("DEBUG: offset=%08x, next=%08x, diff=%08x" % (region.flash_offset, next_start, next_start - region.flash_offset))
            region.max_size = min(region.max_size, next_start - region.flash_offset)
            next_start = region.flash_offset

        for k,v in self.regions.items():
            currsz = len(v.data)
            maxsz = v.max_size
            print("%-18s %8d (%3d %%, max %7s)" % (k + " size:", currsz, 100*currsz/maxsz, format_size(maxsz)))
            #if len(v.data) > v.max_size:
            #    raise Exception("Region %s is too big: %d > %d" % (k, currsz, maxsz))

    def collect_data(self):
        data = bytearray(b'\xff' * self.flash_size)
        for k,v in self.regions.items():
            data[v.flash_offset:v.flash_offset+len(v.data)] = v.data
        return data

whole_img_base = 0xD2000

def make_regions():
    regions = FlashRegions(8*MB)
    #NOTE There are additional size requirements, which are checked by the linker scripts for low_load.
    #regions.add("low_load_m0", "low_load_bl808_m0.bin", 0x00002000, 0x58000000)
    #regions.add("low_load_d0", "low_load_bl808_d0.bin", 0x00052000, 0x58000000)  # same load address because it will be "loaded" by XIP mapping
    regions.add("dtb",         "bl808-pine64-ox64.dtb", whole_img_base, 0x51ff8000)
    regions.add("opensbi",     "fw_jump.bin",           whole_img_base+0x10000, 0x3eff0000, max_size=0xc800)  # only with patched low_load_d0; otherwise, 0xc000
    regions.add("linux",       "Image.lz4",             whole_img_base+0x20000, 0x50000000)
    regions.add("linux_header", None,                   regions.linux.flash_offset - 8, 0)
    return regions

if __name__ == '__main__':
    regions = make_regions()
    regions.read()

    # old script was adding a zero byte to the dtb so let's do the same
    # -> actually, let's skip that because it was adding a zero byte to everything.
    #regions.dtb.data += b'\0'
    # add header to Linux image (TODO: what does it do? is this for LZ4?)
    regions.linux_header.data = b'\0\0\0\x50' + struct.pack('<I', len(regions.linux.data))

    regions.check()

    flash_data = regions.collect_data()
    flash_data = flash_data[whole_img_base:]  # low_load_* is programmed with BLDevCube; we start at dtb
    with open("whole_img_linux.bin", "wb+") as f:
        f.write(flash_data)

