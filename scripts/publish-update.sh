#!/bin/sh
scrdir=$(dirname "$0")
. "$scrdir/_set_passphrase_arg.sh"
aptly publish update "$passphrase_arg" $1
