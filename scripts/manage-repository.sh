#!/bin/sh
scrdir=$(dirname "$0")
command=$1
distribution=$2
component=$3
. "$scrdir/_set_passphrase_arg.sh"
if [ ! -d /miktex/aptly/public/dists/$distribution/$component ]; then
    aptly repo create -distribution=$distribution -component=$component miktex-$distribution
    aptly publish repo -architectures=amd64 "$passphrase_arg" miktex-$distribution
fi
case $command in
    add)
	aptly repo add miktex-$distribution /miktex/debs/*.deb
	;;
    publish)
	aptly publish update "$passphrase_arg" $distribution
	;;
    cleanup)
	j2000_today=$(( ($(date +%s) - $(date --date="000101" +%s) ) / (60*60*24) ))
	j2000=$(( $j2000_today - 365 ))
	aptly repo remove miktex-$distribution "miktex (< 2.9.$j2000)"
	;;
    show)
	aptly repo show -with-packages miktex-$distribution
	;;
    *)
	echo "unknown command"
	exit 1
	;;
esac
