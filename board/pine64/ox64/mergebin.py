#!/usr/bin/env python3
# Description: Merge the Kernel, DTB, and OpenSBI into a single binary
# From @BBBSnowball
import struct
import argparse
from math import inf

kB = 1024
MB = 1024*1024

VM_BOOT_SECTION_HEADER = 0
VM_BOOT_SECTION_DTB = 1
VM_BOOT_SECTION_OPENSBI = 2
VM_BOOT_SECTION_KERNEL = 3


def format_size(x):
    if (x % MB) == 0:
        return "%d MB" % (x/MB)
    elif (x % kB) == 0:
        return "%d kB" % (x/kB)
    else:
        return "%d bytes" % x

class FlashRegion(object):
    def __init__(self, from_file, region_type, flash_offset, max_size=inf):
        self.from_file = from_file
        self.region_type = region_type
        self.flash_offset = flash_offset
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
            print("DEBUG: offset=%08x, next=%08x, diff=%08x" % (region.flash_offset, next_start, next_start - region.flash_offset))
            region.max_size = min(region.max_size, next_start - region.flash_offset)
            next_start = region.flash_offset

        for k,v in self.regions.items():
            currsz = len(v.data)
            maxsz = v.max_size
            print("%-18s %d - %8d (%3d %%, max %7s) - Start %08x" % (k + " size:", v.region_type, currsz, 100*currsz/maxsz, format_size(maxsz), v.flash_offset))
            if len(v.data) > v.max_size:
                raise Exception("Region %s is too big: %d > %d" % (k, currsz, maxsz))

    def collect_data(self):
        # typedef enum {
        #     VM_BOOT_SECTION_HEADER = 0,
        #     VM_BOOT_SECTION_DTB
        #     VM_BOOT_SECTION_OPENSBI,
        #     VM_BOOT_SECTION_KERNEL,
        #     VM_BOOT_SECTION_MAX,
        # } vm_boot_section_t;

        # typedef struct {
        #     uint32_t magic;
        #     uint32_t version;
        #     uint32_t sections;
        #     uint32_t crc;
        #     struct {
        #         uint32_t type;
        #         uint32_t offset;
        #         uint32_t size;
        #     } section[];
        #
        # } vm_boot_header_t;
        regions.header.data = struct.pack('<IIII', 0x4c4d5642, 1, len(self.regions)-1, 0)
        for k,v in self.regions.items():
            if v.region_type == VM_BOOT_SECTION_HEADER:
                continue
            regions.header.data += struct.pack('<IIII', 0x5c2381b2, v.region_type, v.flash_offset, len(v.data))

        data = bytearray(b'\xff' * self.flash_size)
        for k,v in self.regions.items():
            data[v.flash_offset:v.flash_offset+len(v.data)] = v.data
        return data

#whole_img_base = 0xD2000
whole_img_base = 0x00000000

def make_regions():
    regions = FlashRegions(704*kB)
    regions.add('header',      None,                    VM_BOOT_SECTION_HEADER,     whole_img_base,                                             max_size=0x100)
    regions.add("dtb",         args.dtb,                VM_BOOT_SECTION_DTB,        whole_img_base + regions.header.max_size,                   max_size=0x8000)
    regions.add("opensbi",     args.sbi,           VM_BOOT_SECTION_OPENSBI,    regions.dtb.flash_offset + regions.dtb.max_size,            max_size=0x20000)
    regions.add("linux",       args.kernel,             VM_BOOT_SECTION_KERNEL,     regions.opensbi.flash_offset + regions.opensbi.max_size    )
    return regions


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
                    prog = 'mergebin.py',
                    description = 'Creates a Single Binary Image of the kernel, opensbi and dts files')
    parser.add_argument('-o', '--output', help='Output file name', required=True)
    parser.add_argument('-d', '--dtb', help='DTB file name', required=True)
    parser.add_argument('-k', '--kernel', help='Kernel file name', required=True)
    parser.add_argument('-s', '--sbi', help='OpenSBI file name', required=True)
    args = parser.parse_args()

    regions = make_regions()
    regions.read()

    regions.check()

    with open(args.output, "wb+") as f:
        f.write(regions.collect_data())

