FROM docker.io/alpine:3.20.0

# https://git.savannah.gnu.org/gitweb/?p=gettext.git;a=blob_plain;f=NEWS;hb=master
# https://git.alpinelinux.org/aports/log/main/gettext?h=3.20-stable
ARG GETTEXT_PACKAGE_VERSION=0.22.5-r0
# https://gitweb.torproject.org/tor.git/plain/ChangeLog
# https://gitlab.torproject.org/tpo/core/tor/-/raw/release-0.4.8/ReleaseNotes
# https://git.alpinelinux.org/aports/log/community/tor?h=3.20-stable
ARG TOR_PACKAGE_VERSION=0.4.8.11-r0
RUN apk add --no-cache \
        tor=$TOR_PACKAGE_VERSION \
        gettext-envsubst=$GETTEXT_PACKAGE_VERSION \
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
