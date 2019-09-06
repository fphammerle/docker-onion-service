# https://pkgs.alpinelinux.org/packages?name=obfs4proxy&arch=x86_64
FROM alpine:3.10

RUN adduser -S onion \
    && apk add --no-cache tor=~0.3.5.8 \
    && apk add --no-cache obfs4proxy=~0.0.7 \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

ENV OR_PORT=
ENV PT_PORT=
ENV CONTACT_INFO=
COPY torrc.template /
RUN chmod a+r /torrc.template

COPY entrypoint.sh /
RUN chmod a+rx /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER onion

CMD ["tor", "-f", "/tmp/torrc"]
