################################################################################
#
# BLMCUSDK
#
################################################################################

RISCV_UNKNOWN_ELF_GCC_VERSION = c4afe91
RISCV_UNKNOWN_ELF_GCC_SITE = https://gitee.com/bouffalolab/toolchain_gcc_t-head_linux.git
RISCV_UNKNOWN_ELF_GCC_SITE_METHOD = git



define HOST_RISCV_UNKNOWN_ELF_GCC_INSTALL_CMDS
	$(call SYSTEM_RSYNC,$(@D),$(HOST_DIR)/usr/)
	rm $(HOST_DIR)/usr/bin/riscv64-unknown-elf-lto-dump
	rm $(HOST_DIR)/usr/bin/riscv64-unknown-elf-gcov
endef

#$(eval $(generic-package))
$(eval $(host-generic-package))

