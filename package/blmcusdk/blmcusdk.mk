################################################################################
#
# BLMCUSDK
#
################################################################################

BLMCUSDK_VERSION = 356f258e83cf9f39598c593710dd95e31c0627e7
BLMCUSDK_SITE = $(call github,bouffalolab,bl_mcu_sdk,$(BLMCUSDK_VERSION))

BLMCUSDK_LICENSE =  Apache-2.0 license
BLMCUSDK_LICENSE_FILES = LICENSE

HOST_BLMCUSDK_DEPENDENCIES = host-cmake host-riscv-unknown-elf-gcc

define HOST_BLMCUSDK_INSTALL_CMDS
	$(call SYSTEM_RSYNC,$(@D),$(HOST_DIR)/opt/bl_mcu_sdk)
endef

#$(eval $(generic-package))
$(eval $(host-generic-package))

# variables used by other packages
BL_SDK_BASE = $(HOST_DIR)/opt/bl_mcu_sdk
#AUTOCONF = $(HOST_DIR)/bin/autoconf -I "$(ACLOCAL_DIR)" -I "$(ACLOCAL_HOST_DIR)"
#AUTOHEADER = $(HOST_DIR)/bin/autoheader -I "$(ACLOCAL_DIR)" -I "$(ACLOCAL_HOST_DIR)"
#AUTORECONF = $(HOST_CONFIGURE_OPTS) ACLOCAL="$(ACLOCAL)" AUTOCONF="$(AUTOCONF)" AUTOHEADER="$(AUTOHEADER)" AUTOMAKE="$(AUTOMAKE)" AUTOPOINT=/bin/true GTKDOCIZE=/bin/true $(HOST_DIR)/bin/autoreconf -f -i
