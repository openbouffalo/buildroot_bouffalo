################################################################################
#
# afboot-stm32
#
################################################################################

OBLFR_VERSION = 7745fe6d6cd72d8a1a3682ff5176bc642475a0e3
OBLFR_SITE = git@github.com:bouffalolab/bflb_linux_fw.git
OBLFR_SITE_METHOD = git
OBLFR_GIT_SUBMODULES = YES
OBLFR_INSTALL_IMAGES = YES
OBLFR_INSTALL_TARGET = NO
OBLFR_DEPENDENCIES = host-cmake host-riscv-unknown-elf-gcc host-python3

define OBLFR_BUILD_CMDS
	cd $(@D)/apps/d0_lowload && $(TARGET_MAKE_ENV) $(CLOUDUTILS_MAKE_ENV) $(MAKE) -C $(@D)/apps/d0_lowload
	cd $(@D)/apps/m0_lowload && $(TARGET_MAKE_ENV) $(CLOUDUTILS_MAKE_ENV) $(MAKE) -C $(@D)/apps/m0_lowload
endef

define OBLFR_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) -D $(@D)/apps/d0_lowload/build/build_out/*.bin
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) -D $(@D)/apps/m0_lowload/build/build_out/*.bin
endef

$(eval $(generic-package))
