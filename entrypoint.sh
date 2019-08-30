#!/bin/sh

set -e

[ -z "$OR_PORT" ] && echo '$OR_PORT undefined' && exit 1
[ -z "$PT_PORT" ] && echo '$PT_PORT undefined' && exit 1

set -x

sed -e "s#{OR_PORT}#$OR_PORT#" \
    -e "s#{PT_PORT}#$PT_PORT#" \
    -e "s#{CONTACT_INFO}#$CONTACT_INFO#" \
    /torrc.template >/tmp/torrc

exec "$@"
