#!/bin/sh

set -e

cygwin64_prefix=/usr/@TRIPLE@

# run it in a custom WINEPREFIX to not mess with default ~/.wine
# also default prefix might be a 32 bits prefix, which will fail to run x86_64 exes
export WINEPREFIX=${HOME}/.wine-@TRIPLE@

if test "@TRIPLE@" = "x86_64-pc-cygwin"
then
  export WINEARCH=win64
else
  export WINEARCH=win32
fi

if test -z ${WINEDLLOVERRIDES+x}
then
  export WINEDLLOVERRIDES="mscoree,mshtml="
fi

if test -z ${WINEDEBUG+x}
then
  export WINEDEBUG=-all
fi

/usr/bin/msiexec "$@"

