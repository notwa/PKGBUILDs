here are some PKGBUILDs i've either modified or written over the years.
some of them are for Arch Linux, some of them are for MSYS2,
some of them work with both.
heads up: these are likely to be out of date.

### mingw-w64-nim

patches nim 1.0.0 to compile with MSYS2, and use MSYS2 paths/DLLs.
a few things might not work, but the core functionality
(including nimble) is working.

**NOTE:** you'll want a `cacert.pem` somewhere in your PATH.
for example, (don't actually use this path):
```
curl -LsS https://curl.se/ca/cacert.pem -o /c/Windows/cacert.pem
```

### mingw-w64-tbox

patches tbox to compile/run with MSYS2.
*a lot of stuff* isn't working yet.

### n64-toolkit

builds a cross-compiler for N64 homebrew.
works on both Arch and MSYS2.

installs to `/opt/mips-ultra64-elf`, so add that to your PATH as needed.

### xml2

modified to download from a mirror.
the original URL is offline.

## mxe-plugins

there's some mxe stuff in this repo too.
just add the directory to your plugins variable, like this:
```
make ffmpeg MXE_PLUGIN_DIRS=/path/to/PKGBUILDs/mxe-plugins/notwa
```

### ffmpeg

this package has been tweaked to build a more recent version
and to enable(-nonfree) some stuff they tell you not to.
there's licensing conflicts, so don't redistribute the resulting binaries.

### mpv

builds mpv with most of the features available to mxe.
it's not as fully-featured [as other builds,][mpvother]
but it gets the job done.

[mpvother]: https://github.com/lachs0r/mingw-w64-cmake

### ladspa

this just downloads and installs `ladspa.h`.

### waf

this just downloads and installs `waf`.
it's the same as the package provided with mxe,
except the version has been updated
to the one mpv recommends to build with.
