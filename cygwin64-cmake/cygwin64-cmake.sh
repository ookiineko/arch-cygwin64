#!/bin/bash

. /usr/bin/cygwin64-env

cygwin64_prefix=/usr/@TRIPLE@

PATH=${cygwin64_prefix}/bin:$PATH cmake \
    -DCMAKE_INSTALL_PREFIX:PATH=${cygwin64_prefix} \
    -DCMAKE_INSTALL_LIBDIR:PATH=lib \
    -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${cygwin64_prefix}/include \
    -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${cygwin64_prefix}/include \
    -DCMAKE_BUILD_TYPE=None \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DSYSCONF_INSTALL_DIR:PATH=${cygwin64_prefix}/etc \
    -DSHARE_INSTALL_PREFIX:PATH=${cygwin64_prefix}/share \
    -DCMAKE_TOOLCHAIN_FILE=/usr/share/cygwin64/toolchain-@TRIPLE@.cmake \
    -DCMAKE_CROSSCOMPILING_EMULATOR=/usr/bin/@TRIPLE@-wine \
    "$@"
