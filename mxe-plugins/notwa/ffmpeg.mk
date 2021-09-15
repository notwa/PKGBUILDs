# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ffmpeg
$(PKG)_WEBSITE  := https://ffmpeg.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3e127b5
$(PKG)_CHECKSUM := be2f174680648bed2c5e7305c39143f25e457a30fe04b168d3973baff789e4c0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://git.ffmpeg.org/gitweb/ffmpeg.git/snapshot/$($(PKG)_FILE)
$(PKG)_DEPS     := bzip2 cc fdk-aac fontconfig freetype fribidi gnutls \
                   ladspa lame libass libbluray libbs2b libcaca \
                   librtmp libvpx libwebp opencore-amr opus sdl speex theora \
                   vidstab vo-amrwbenc vorbis x264 xvidcore yasm zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://git.ffmpeg.org/gitweb/ffmpeg.git/shortlog' | \
    $(SED) -n 's,.*/commit/\([a-f0-9]\{7\}\).*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        --cross-prefix='$(TARGET)'- \
        --enable-cross-compile \
        --arch=$(firstword $(subst -, ,$(TARGET))) \
        --target-os=mingw32 \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), \
            --enable-static --disable-shared , \
            --disable-static --enable-shared ) \
        --x86asmexe='$(TARGET)-yasm' \
        --disable-debug \
        --disable-pthreads \
        --enable-w32threads \
        --disable-ffplay --disable-ffprobe \
        --disable-doc \
        --enable-gpl \
        --enable-version3 \
        --enable-nonfree \
        \
        --extra-libs='-mconsole' \
        --enable-gnutls \
        --enable-libass \
        --enable-libbluray \
        --enable-libbs2b \
        --enable-libcaca \
        --enable-libfdk-aac \
        --enable-libmp3lame \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-libopus \
        --enable-librtmp \
        --enable-libspeex \
        --enable-libtheora \
        --enable-libvidstab \
        --enable-libvo-amrwbenc \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libx264 \
        --enable-libxvid \
        \
        --enable-ladspa \
        --enable-libass \
        --enable-libfreetype --enable-libfontconfig --enable-libfribidi \
        --enable-libvidstab \
        --enable-bzlib --enable-zlib \
        $($(PKG)_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
