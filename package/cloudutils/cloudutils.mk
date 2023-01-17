CLOUDUTILS_VERSION = 0.33
CLOUDUTILS_SITE =  $(call github,canonical,cloud-utils,$(CLOUDUTILS_VERSION))
CLOUDUTILS_LICENSE = GPL-3.0
CLOUDUTILS_DEPENDENCIES = 

define CLOUDUTILS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(CLOUDUTILS_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))