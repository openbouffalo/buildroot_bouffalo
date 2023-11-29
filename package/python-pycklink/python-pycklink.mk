################################################################################
#
# python-pycklink
#
################################################################################

PYTHON_PYCKLINK_VERSION = 0.1.1
PYTHON_PYCKLINK_SOURCE = pycklink-$(PYTHON_PYCKLINK_VERSION).tar.gz
PYTHON_PYCKLINK_SITE = https://files.pythonhosted.org/packages/7a/aa/ba1ff6fbfe81db938be73ced378230002eb2bb45cb8f81dd39b79ac6c08f
PYTHON_PYCKLINK_SETUP_TYPE = setuptools
PYTHON_PYCKLINK_LICENSE = MIT
PYTHON_PYCKLINK_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
