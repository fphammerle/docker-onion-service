FROM alpine:3.8

RUN apk add --no-cache tor

RUN adduser -S onion
RUN mkdir -m u=rwx,g=,o= /onion-service && chown onion /onion-service
VOLUME /onion-service

COPY --chown=onion:nobody torrc.template /

USER onion

ENV VIRTUAL_PORT 80
ENV TARGET 127.0.0.1:8080
CMD sed -e "s#{virtual_port}#$VIRTUAL_PORT#" -e "s#{target}#$TARGET#" /torrc.template >/tmp/torrc \
    && tor -f /tmp/torrc
