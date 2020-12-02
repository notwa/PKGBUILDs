# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpv
$(PKG)_WEBSITE  := https://mpv.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 84d0930
$(PKG)_CHECKSUM := 54535ce27efce73988249eda1591dc236de9db21f51f4aa1998cbe2ef844c243
$(PKG)_GH_CONF  := mpv-player/mpv/branches/master
$(PKG)_DEPS     := cc ffmpeg fribidi lcms \
                   libarchive libass libdvdnav libdvdread libiconv \
                   jpeg libpng luajit rubberband pthreads sdl2 $(BUILD)~waf

define $(PKG)_BUILD
    cd '$(1)' && DEST_OS=win32 TARGET=$(TARGET) python3 '$(PREFIX)/$(BUILD)/bin/waf' \
        configure build install -j '$(JOBS)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), \
            --enable-static-build --disable-libmpv-shared , \
            --disable-static-build --enable-libmpv-shared ) \
        --disable-manpage-build \
        --enable-dvdnav \
        --enable-lcms2 \
        --enable-libarchive \
        --enable-libbluray \
        --enable-lua \
        --enable-rubberband \
        --enable-sdl2
endef
