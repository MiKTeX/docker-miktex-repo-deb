#!/bin/sh
gpg --batch --import /miktex/signing.sec
if [ ! -z "$MIKTEX_PASSPHRASE" ]; then
    export passphrase_arg=-passphrase=$MIKTEX_PASSPHRASE
elif [ -f /miktex/passphrase ]; then
    export passphrase_arg=-passphrase-file=/miktex/passphrase
fi
if [ ! -d /miktex/aptly/public/dists/$1/$2 ]; then
    aptly repo create -distribution=$1 -component=$2 miktex-$1
    aptly publish repo -architectures=amd64 $passphrase_arg miktex-$1
fi
aptly repo add miktex-$1 /miktex/debs/*.deb
aptly publish update $passphrase_arg $1
