if [ -z "$passphrase_arg" ]; then
    gpg --list-keys
    cat /miktex/gpg.conf >> ~/.gnupg/gpg.conf
    gpg --batch --import /miktex/signing.sec
    if [ ! -z "$MIKTEX_PASSPHRASE" ]; then
	export "passphrase_arg=-passphrase=$MIKTEX_PASSPHRASE"
    elif [ -f /miktex/passphrase ]; then
	export "passphrase_arg=-passphrase-file=/miktex/passphrase"
    fi
fi
