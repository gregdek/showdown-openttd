FROM ubuntu:18.04
MAINTAINER Mats Bergmann <bateau@sea-shell.org>

ARG OPENTTD_VERSION="1.9.3"
ARG OPENGFX_VERSION="0.5.5"

ADD prepare.sh /tmp/prepare.sh
ADD cleanup.sh /tmp/cleanup.sh
ADD buildconfig /tmp/buildconfig
ADD --chown=1000:1000 openttd.sh /openttd.sh

RUN /tmp/prepare.sh \
    && /tmp/cleanup.sh

VOLUME /home/openttd/.openttd

EXPOSE 3979/tcp
EXPOSE 3979/udp

STOPSIGNAL 3
ENTRYPOINT [ "/usr/bin/dumb-init", "--rewrite", "15:3", "--rewrite", "9:3", "--" ]
CMD [ "/openttd.sh" ]
