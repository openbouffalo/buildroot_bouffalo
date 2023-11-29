################################################################################
#
# python-pylink-square
#
################################################################################

PYTHON_PYLINK_SQUARE_VERSION = 1.2.0
PYTHON_PYLINK_SQUARE_SOURCE = pylink-square-$(PYTHON_PYLINK_SQUARE_VERSION).tar.gz
PYTHON_PYLINK_SQUARE_SITE = https://files.pythonhosted.org/packages/4d/01/d63b65a9e23da016da962b01cb4c30fd9132ce6408550697169d5a9c9278
PYTHON_PYLINK_SQUARE_SETUP_TYPE = setuptools
PYTHON_PYLINK_SQUARE_LICENSE = Apache 2.0
PYTHON_PYLINK_SQUARE_LICENSE_FILES = LICENSE.md

$(eval $(host-python-package))
