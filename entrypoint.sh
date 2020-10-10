#!/bin/sh

set -eu

envsubst </torrc.template >/tmp/torrc

exec "$@"
