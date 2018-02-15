# Docker image for managing a MiKTeX-specific Debian package repository

## Obtaining the image

Get the latest image from the registry:

    docker pull miktex/miktex-repo-deb

or build it yourself:

    docker build --tag miktex/miktex-repo-deb .

## Using the image

### Prerequisites

1. The directory containing the .deb file(s) must be mounted to the
   container path `/miktex/debs`.

2. The secret key file for GPG signing must be mounted to the
   container path `/miktex/signing.sec`.

3. The passphrase for the signing key can be stored in the container
   environment variable `MIKTEX_PASSPHRASE` or in the container file
   `/miktex/passphrase`.  This step is optional.  If you don't write
   the passphrase to `MIKTEX_PASSPHRASE` or `/miktex/passphrase`, then
   you will be prompted to enter it when GPG signs the release.

4. Two arguments must be supplied for the container entrypoint:
   1. the distribution name (e.g., `xenial`)
   2. the distribution-specific component name (e.g., `universe`)

5. The repository is managed with the help of
   [aptly](https://www.aptly.info).  The aptly root directory must be
   mounted to the container path `/miktex/aptly`.

You should specify a user by setting the container environment
variables `USER_ID` and `GROUP_ID`.

### Example

Create a repository containing MiKTeX deb packages for Ubuntu 16.04
(Xenial).

    mkdir -p ~/work/miktex/xenial
    # create .deb files in ~/work/miktex/xenial
    gpg --export-secret-keys > /tmp/shred.me
    mkdir -p ~/work/miktex/aptly
    docker run --rm -ti \
      -v ~/work/miktex/xenial:/miktex/debs:ro \
      -v /tmp/shred.me:/miktex/signing.sec:ro \
      -v ~/work/miktex/aptly:/miktex/aptly:rw \
      -e USER_ID=`id -u` \
      -e GROUP_ID=`id -g` \
      miktex/miktex-repo-deb xenial universe
    shred -u /tmp/shred.me
