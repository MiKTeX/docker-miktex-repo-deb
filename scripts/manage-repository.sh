#!/bin/sh
scrdir=$(dirname "$0")
. "$scrdir/_set_passphrase_arg.sh"
if [ ! -d /miktex/aptly/public/dists/$1/$2 ]; then
    aptly repo create -distribution=$1 -component=$2 miktex-$1
    aptly publish repo -architectures=amd64 "$passphrase_arg" miktex-$1
fi
aptly repo add miktex-$1 /miktex/debs/*.deb
aptly publish update "$passphrase_arg" $1
