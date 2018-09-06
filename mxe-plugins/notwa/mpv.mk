# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpv
$(PKG)_WEBSITE  := https://mpv.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 91786fa
$(PKG)_CHECKSUM := b934a7f842cb0bc9518cfb46f2dfd69d6e924022ba7ba73c63d36e48266fae89
$(PKG)_GH_CONF  := mpv-player/mpv/master
$(PKG)_DEPS     := cc ffmpeg fribidi lcms \
                   libarchive libass libdvdnav libdvdread libiconv \
                   jpeg libpng luajit rubberband pthreads sdl2 $(BUILD)~waf

define $(PKG)_BUILD
    cd '$(1)' && DEST_OS=win32 TARGET=$(TARGET) '$(PREFIX)/$(BUILD)/bin/waf' \
        configure build install -j '$(JOBS)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), \
            --enable-static-build --disable-libmpv-shared , \
            --disable-static-build --enable-libmpv-shared ) \
        --disable-manpage-build \
        --enable-dvdnav \
        --enable-dvdread \
        --enable-lcms2 \
        --enable-libarchive \
        --enable-libass \
        --enable-libbluray \
        --enable-lua \
        --enable-rubberband \
        --enable-sdl2 \
        --enable-static-build
endef
