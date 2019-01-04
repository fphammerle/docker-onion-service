FROM arm32v6/alpine:3.8

RUN apk add --no-cache tor

RUN adduser -S onion
RUN mkdir -m u=rwx,g=,o= /onion-service && chown onion /onion-service
VOLUME /onion-service

COPY torrc.template /
RUN chmod a+r /torrc.template

ENV VERSION 3
ENV VIRTUAL_PORT 80
ENV TARGET 127.0.0.1:8080

COPY entrypoint.sh /
RUN chmod a+rx /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER onion

CMD ["tor", "-f", "/tmp/torrc"]
