################################################################################
#
# blwnet_xram
#
################################################################################

BLWNET_XRAM_VERSION = 2c00744670af7af3281e62677fafface3536617a
BLWNET_XRAM_SITE = $(call github,bouffalolab,blwnet_xram,$(BLWNET_XRAM_VERSION))
BLWNET_XRAM_LICENSE = GPL-2.0(kernel driver), Apache 2.0(userspace)

BLWNET_XRAM_MODULE_MAKE_OPTS = \
	CONFIG_BL_INTF=XRAM

define BLWNET_XRAM_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
endef

define BLWNET_XRAM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/userspace
endef

BLWRET_XRAM_USERSPACE_INSTALL_FILES = blctl sta.sh blctld ap.sh

define BLWNET_XRAM_INSTALL_TARGET_CMDS
	$(foreach f,$(BLWRET_XRAM_USERSPACE_INSTALL_FILES),\
		$(INSTALL) -D -m 0755 $(@D)/userspace/$(f) $(TARGET_DIR)/usr/bin
	)
	$(INSTALL) -D -m 644 $(@D)/fw/bl808-m0-fh.bin $(TARGET_DIR)/lib/firmware/bl808-m0-fh.bin
endef

$(eval $(kernel-module))
$(eval $(generic-package))
