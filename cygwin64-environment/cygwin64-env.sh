#!/bin/sh

_target=x86_64-pc-cygwin

default_cygwin64_pp_flags="-D_FORTIFY_SOURCE=2"
default_cygwin64_compiler_flags="$default_cygwin64_pp_flags -O2 -pipe -fexceptions --param=ssp-buffer-size=4 -Wall"
default_cygwin64_linker_flags="-fstack-protector -lssp"

export CPPFLAGS="${cygwin64_CPPFLAGS:-$default_cygwin64_pp_flags $CPPFLAGS}"
export CFLAGS="${cygwin64_CFLAGS:-$default_cygwin64_compiler_flags $CFLAGS}"
export CXXFLAGS="${cygwin64_CXXFLAGS:-$default_cygwin64_compiler_flags $CXXFLAGS}"
export LDFLAGS="${cygwin64_LDFLAGS:-$default_cygwin64_linker_flags $LDFLAGS}"

export CC="${cygwin64_CC:-$_target-gcc}"
export CXX="${cygwin64_CXX:-$_target-g++}"

cygwin64_prefix=/usr/${_target}
export PKG_CONFIG_SYSROOT_DIR="${cygwin64_prefix}"
export PKG_CONFIG_LIBDIR="${cygwin64_prefix}/lib/pkgconfig:${cygwin64_prefix}/share/pkgconfig"
