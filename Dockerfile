FROM alpine:3.12

ARG NETCAT_PACKAGE_VERSION=1.130-r1
ARG TOR_PACKAGE_VERSION=0.4.3.5-r0
RUN apk add --no-cache \
        netcat-openbsd=$NETCAT_PACKAGE_VERSION \
        tor=$TOR_PACKAGE_VERSION \
    && adduser -S onion \
    && mkdir -m u=rwx,g=,o= /onion-service \
    && chown onion /onion-service
VOLUME /onion-service

COPY torrc.template entrypoint.sh /
RUN chmod -c a+rX /torrc.template /entrypoint.sh
ENV VERSION 3
ENV VIRTUAL_PORT 80
ENV TARGET 1.2.3.4:8080
ENTRYPOINT ["/entrypoint.sh"]

USER onion
CMD ["tor", "-f", "/tmp/torrc"]

HEALTHCHECK CMD \
    nc -x localhost:9050 -z "$(cat /onion-service/hostname)" "$VIRTUAL_PORT" \
    || exit 1
