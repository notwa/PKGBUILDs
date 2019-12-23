# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ffmpeg
$(PKG)_WEBSITE  := https://ffmpeg.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := f09ae73
$(PKG)_CHECKSUM := 968fcaba54b5b245f477ba5236412cb690714327a28c65a5f2bee5d77ab67b96
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://git.ffmpeg.org/gitweb/ffmpeg.git/snapshot/$($(PKG)_FILE)
$(PKG)_DEPS     := bzip2 cc fdk-aac fontconfig freetype \
                   fribidi gnutls ladspa lame \
                   libass libbluray libbs2b libcaca librtmp libvpx libwebp \
                   opencore-amr opus sdl speex theora vidstab \
                   vo-amrwbenc vorbis x264 xvidcore yasm zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://git.ffmpeg.org/gitweb/ffmpeg.git/shortlog' | \
    $(SED) -n 's,.*/commit/\([a-f0-9]\{7\}\).*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --cross-prefix='$(TARGET)'- \
        --enable-cross-compile \
        --arch=$(firstword $(subst -, ,$(TARGET))) \
        --target-os=mingw32 \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), \
            --enable-static --disable-shared , \
            --disable-static --enable-shared ) \
        --yasmexe='$(TARGET)-yasm' \
        --disable-debug \
        --disable-pthreads \
        --enable-w32threads \
        --disable-ffplay --disable-ffprobe \
        --disable-doc \
        --enable-avresample \
        --enable-gpl \
        --enable-version3 \
        --enable-nonfree \
        \
        --extra-libs='-mconsole' \
        --enable-avisynth \
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
        --enable-bzlib --enable-zlib
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
