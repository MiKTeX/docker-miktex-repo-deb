FROM ubuntu:jammy

LABEL Description="Debian repository management for MiKTeX" Vendor="Christian Schenk" Version="22.7"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           aptly \
           ca-certificates \
           curl \
           gnupg \
           gosu

COPY conf/aptly.conf /etc/

RUN mkdir /miktex
WORKDIR /miktex

COPY conf/gpg.conf /miktex/
COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/repo-show.sh"]
