#!/bin/sh

set -eux

# alternative: https://pkgs.alpinelinux.org/contents?file=envsubst&path=&name=&branch=v3.12
sed -e "s#{version}#$VERSION#" \
    -e "s#{virtual_port}#$VIRTUAL_PORT#" \
    -e "s#{target}#$TARGET#" \
    /torrc.template >/tmp/torrc

exec "$@"
