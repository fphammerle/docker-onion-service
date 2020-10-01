#!/bin/sh

set -eux

sed -e "s#{version}#$VERSION#" \
    -e "s#{virtual_port}#$VIRTUAL_PORT#" \
    -e "s#{target}#$TARGET#" \
    /torrc.template >/tmp/torrc

exec "$@"
