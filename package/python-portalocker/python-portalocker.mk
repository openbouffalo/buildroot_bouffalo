################################################################################
#
# python-portalocker
#
################################################################################

PYTHON_PORTALOCKER_VERSION = v2.0.0
PYTHON_PORTALOCKER_SITE = $(call github,wolph,portalocker,$(PYTHON_PORTALOCKER_VERSION))
PYTHON_PORTALOCKER_SETUP_TYPE = setuptools
PYTHON_PORTALOCKER_LICENSE = BSD-3-CLAUSE
PYTHON_PORTALOCKER_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
