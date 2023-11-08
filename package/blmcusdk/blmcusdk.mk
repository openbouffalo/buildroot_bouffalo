################################################################################
#
# BLMCUSDK
#
################################################################################

BLMCUSDK_VERSION = openbouffalo_compat
BLMCUSDK_SITE = $(call github,Pavlos1,bouffalo_sdk_oss,$(BLMCUSDK_VERSION))

BLMCUSDK_LICENSE =  Apache-2.0 license
BLMCUSDK_LICENSE_FILES = LICENSE

HOST_BLMCUSDK_DEPENDENCIES = host-cmake host-python-portalocker host-python-serial host-python-ecdsa host-python-six host-python-psutil host-riscv-unknown-elf-gcc host-python-bflb-crypto-plus host-python-psutil host-python-pycklink host-python-pycryptodome host-python-pylink-square

define HOST_BLMCUSDK_INSTALL_CMDS
	@mkdir -p $(HOST_DIR)/opt
	$(call SYSTEM_RSYNC,$(@D),$(HOST_DIR)/opt/bl_mcu_sdk)
endef

#$(eval $(generic-package))
$(eval $(host-generic-package))

# variables used by other packages
BL_SDK_BASE = $(HOST_DIR)/opt/bl_mcu_sdk
#AUTOCONF = $(HOST_DIR)/bin/autoconf -I "$(ACLOCAL_DIR)" -I "$(ACLOCAL_HOST_DIR)"
#AUTOHEADER = $(HOST_DIR)/bin/autoheader -I "$(ACLOCAL_DIR)" -I "$(ACLOCAL_HOST_DIR)"
#AUTORECONF = $(HOST_CONFIGURE_OPTS) ACLOCAL="$(ACLOCAL)" AUTOCONF="$(AUTOCONF)" AUTOHEADER="$(AUTOHEADER)" AUTOMAKE="$(AUTOMAKE)" AUTOPOINT=/bin/true GTKDOCIZE=/bin/true $(HOST_DIR)/bin/autoreconf -f -i
