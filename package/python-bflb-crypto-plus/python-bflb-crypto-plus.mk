################################################################################
#
# python-bflb-crypto-plus
#
################################################################################

PYTHON_BFLB_CRYPTO_PLUS_VERSION = 1.0
PYTHON_BFLB_CRYPTO_PLUS_SOURCE = bflb_crypto_plus-$(PYTHON_BFLB_CRYPTO_PLUS_VERSION).tar.gz
PYTHON_BFLB_CRYPTO_PLUS_SITE = https://files.pythonhosted.org/packages/b1/a4/bda733fe91c9b3424627597768bf8ab2cf683f1e81a88544d126f94536bd
PYTHON_BFLB_CRYPTO_PLUS_SETUP_TYPE = setuptools
PYTHON_BFLB_CRYPTO_PLUS_LICENSE = 

$(eval $(host-python-package))
