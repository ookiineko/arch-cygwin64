#!/bin/bash

. /usr/bin/cygwin64-env

# check if last arg is a path to configure, else use parent
for last; do true; done
if test -x "${last}/configure"; then
  config_path="$last"
else
  config_path=".."
fi

${config_path}/configure \
  --host=@TRIPLE@ --target=@TRIPLE@ --build="$CHOST" \
  --prefix=/usr/@TRIPLE@ --exec-prefix=/usr/@TRIPLE@ --bindir=/usr/@TRIPLE@/bin \
  --sbindir=/usr/@TRIPLE@/bin --sysconfdir=/usr/@TRIPLE@/etc --datadir=/usr/@TRIPLE@/share \
  --includedir=/usr/@TRIPLE@/include --libdir=/usr/@TRIPLE@/lib --libexecdir=/usr/@TRIPLE@/libexec \
  --localstatedir=/usr/@TRIPLE@/var --sharedstatedir=/usr/@TRIPLE@/var/lib --mandir=/usr/@TRIPLE@/share/man \
  --infodir=/usr/@TRIPLE@/share/info --enable-shared --enable-static "$@"
