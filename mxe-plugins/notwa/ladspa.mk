# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ladspa
$(PKG)_WEBSITE  := http://www.ladspa.org
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1
$(PKG)_CHECKSUM := c72ceb7383f159a944bfe80b1b155795857026aea1155dbe4ecf1664354320ad
$(PKG)_FILE     := ladspa.h.txt
$(PKG)_URL      := http://www.ladspa.org/ladspa_sdk/$($(PKG)_FILE)
$(PKG)_DEPS     :=
$(PKG)_TYPE     := script

define $(PKG)_BUILD
    $(INSTALL) -m644 '$(PKG_DIR)/ladspa.h.txt' '$(PREFIX)/$(TARGET)/include/ladspa.h'
endef
