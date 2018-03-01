# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpv
$(PKG)_WEBSITE  := https://mpv.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3263f47
$(PKG)_CHECKSUM := a8224fa748ccb89ccdb2a844d696b06785ad28fc1bb0dfda0506897abbc99e9a
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
        --enable-encoding \
        --enable-lcms2 \
        --enable-libarchive \
        --enable-libass \
        --enable-libbluray \
        --enable-lua \
        --enable-rubberband \
        --enable-sdl2 \
        --enable-static-build
endef
