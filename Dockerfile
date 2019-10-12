FROM alpine:3.10

ARG CURL_PACKAGE_VERSION=7.66.0-r0
ARG BIND_TOOLS_PACKAGE_VERSION=9.14.3-r0
ARG TOR_PACKAGE_VERSION=0.4.1.6-r0
ARG TOR_PACKAGE_REPOSITORY=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN adduser -S onion \
    && apk add --no-cache \
        curl=$CURL_PACKAGE_VERSION \
        bind-tools=$BIND_TOOLS_PACKAGE_VERSION `# dig` \
    && apk add --no-cache --repository $TOR_PACKAGE_REPOSITORY \
        tor=$TOR_PACKAGE_VERSION

# RUN apk add --no-cache man less \
#     && apk add --no-cache tor-doc=$TOR_PACKAGE_VERSION \
#        --repository $TOR_PACKAGE_REPOSITORY
# ENV PAGER=less

EXPOSE 9050/tcp
EXPOSE 53/udp
COPY torrc /etc/tor/torrc

CMD ["tor"]

HEALTHCHECK CMD \
    curl --silent --socks5 localhost:9050 https://google.com > /dev/null \
    && [ ! -z "$(dig +notcp +short one.one.one.one @localhost)" ] \
    || exit 1
