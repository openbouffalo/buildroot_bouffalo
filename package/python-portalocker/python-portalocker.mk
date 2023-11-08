################################################################################
#
# python-ecdsa
#
################################################################################

PYTHON_PORTALOCKER_VERSION = master
#PYTHON_ECDSA_SOURCE = ecdsa-$(PYTHON_ECDSA_VERSION).tar.gz
PYTHON_PORTALOCKER_SITE = $(call github,wolph,portalocker,$(PYTHON_PORTALOCKER_VERSION))
PYTHON_PORTALOCKER_SETUP_TYPE = setuptools
PYTHON_PORTALOCKER_LICENSE = BSD-3-CLAUSE
PYTHON_PORTALOCKER_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
