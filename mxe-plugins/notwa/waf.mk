# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := waf
$(PKG)_WEBSITE  := https://waf.io/
$(PKG)_DESCR    := Waf: the meta build system
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.9.8
$(PKG)_CHECKSUM := d8ec47b85e832e97f32d4f83df3cacfa08dbf142c52ad525ee8e1a70ab658472
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://waf.io/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://waf.io/' | \
    $(SED) -n 's,.*waf-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD_$(BUILD)
    mkdir -p '$(PREFIX)/$(BUILD)/bin'
    cp '$(1)/waf' '$(PREFIX)/$(BUILD)/bin/waf'
endef
