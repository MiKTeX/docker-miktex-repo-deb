FROM ubuntu:xenial

LABEL Description="Debian repository management for MiKTeX" Vendor="Christian Schenk" Version="2.9.6707"

RUN    apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
           aptly \
           ca-certificates \
           curl

RUN    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY conf/aptly.conf /etc/

RUN mkdir /miktex
WORKDIR /miktex

COPY conf/gpg.conf /miktex/
COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/repo-show.sh"]
