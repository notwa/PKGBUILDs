here are some PKGBUILDs i've either modified or written over the years.
some of them are for Arch Linux, some of them are for MSYS2,
some of them work with both.
heads up: these are likely to be out of date.

### mingw-w64-nim-git

patches nim to compile with MSYS2, and use MSYS2 paths/DLLs.
a few things aren't working yet, but the core functionality is there.

### mingw-w64-tbox

patches tbox to compile/run with MSYS2.
*a lot of stuff* isn't working yet.

### n64-toolkit

compiles a cross-compiler for N64 homebrew.
works on both Arch and MSYS2.

i need to rename this package at some point.
currently, it doesn't follow any guidelines.

### xml2

modified to download from a mirror.
the original URL is offline.
