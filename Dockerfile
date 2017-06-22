FROM ubuntu:xenial

LABEL Description="Debian repository management for MiKTeX" Vendor="Christian Schenk" Version="2.9.6382"

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460
RUN apt-get update
RUN apt-get install -y aptly

ADD conf/aptly.conf /etc/

RUN mkdir /miktex
ADD scripts/*.sh /miktex/

WORKDIR /miktex

ENTRYPOINT ["/miktex/manage-repository.sh"]
