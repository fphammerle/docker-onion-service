FROM docker.io/alpine:3.14.0

ARG GETTEXT_PACKAGE_VERSION=0.21-r0
ARG TOR_PACKAGE_VERSION=0.4.5.9-r0
RUN apk add --no-cache \
        tor=$TOR_PACKAGE_VERSION \
        gettext=$GETTEXT_PACKAGE_VERSION \
    && mkdir -m u=rwx,g=,o= /onion-service \
    && chown tor /onion-service
VOLUME /var/lib/tor
VOLUME /onion-service

#RUN apk add --no-cache \
#        less \
#        man-db \
#        tor-doc=$TOR_PACKAGE_VERSION
#ENV PAGER=less

COPY torrc.template entrypoint.sh /
RUN chmod -c a+rX /torrc.template /entrypoint.sh
ENV VERSION 3
ENV VIRTUAL_PORT 80
ENV TARGET 1.2.3.4:8080
ENV NON_ANONYMOUS_SINGLE_HOP_MODE 0
ENTRYPOINT ["/entrypoint.sh"]

USER tor
CMD ["tor", "-f", "/tmp/torrc"]

# https://gitweb.torproject.org/torspec.git/tree/control-spec.txt
HEALTHCHECK CMD \
    printf "AUTHENTICATE\nGETINFO network-liveness\nQUIT\n" | nc localhost 9051 \
        | grep -q network-liveness=up || exit 1

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="tor onion service" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-onion-service" \
    org.opencontainers.image.revision="$REVISION"
