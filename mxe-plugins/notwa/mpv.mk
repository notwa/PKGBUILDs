# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpv
$(PKG)_WEBSITE  := https://mpv.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := cd89362
$(PKG)_CHECKSUM := bc0a028613027c545e7a79c6bb3192d84d602040cf416dd24f372c66503452a0
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
