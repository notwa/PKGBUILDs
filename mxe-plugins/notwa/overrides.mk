# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ffmpeg
$(PKG)_WEBSITE  := https://ffmpeg.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := acdea9e
$(PKG)_CHECKSUM := e0c5d95c2f9866bd15ae8beb258e95ec8dc5b491c9640528aa561c651e04a546
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://git.ffmpeg.org/gitweb/ffmpeg.git/snapshot/$($(PKG)_FILE)
$(PKG)_DEPS     := cc bzip2 fdk-aac gnutls lame libass libbluray libbs2b \
                   libcaca librtmp libvpx libwebp opencore-amr opus \
                   sdl speex theora vidstab vo-amrwbenc \
                   vorbis x264 xvidcore yasm zlib \
                   freetype fontconfig fribidi \
                   vidstab


# NOTE: you'll have to manually copy ladspa.h into mxe's usr directory
#cp /usr/include/ladspa.h usr/x86_64-w64-mingw32.static/include/ladspa.h
# --enable-libebur128 \
# --enable-libflite \
# --enable-libzmq \
# --enable-opencl \
# NOTE: opencv should work if you pass the right C++ standard
# --enable-libopencv \
# also has an issue linking using gcc 6
# --enable-netcdf \
# doesn't exist anymore?
# --disable-ffserver \

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
