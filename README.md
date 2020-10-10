# docker: hidden tor .onion service 🐳

repo: https://github.com/fphammerle/docker-onion-service

docker hub: https://hub.docker.com/r/fphammerle/onion-service/tags

signed tags: https://github.com/fphammerle/docker-onion-service/tags

defaults to creating a [v3](https://trac.torproject.org/projects/tor/wiki/doc/NextGenOnions) service

## example 1

```sh
$ sudo docker run --name onion_service \
    -e VIRTUAL_PORT=80 -e TARGET=1.2.3.4:8080 \
    fphammerle/onion-service
```

## example 2

```sh
$ sudo docker create --name onion_service \
    --env VERSION=3 \
    --env VIRTUAL_PORT=80 \
    --env TARGET=1.2.3.4:8080 \
    --volume onion-key:/onion-service \
    --restart unless-stopped \
    --cap-drop all --security-opt no-new-privileges \
    fphammerle/onion-service:latest

$ sudo docker start onion_service
```

optionally add `--read-only --tmpfs /tmp:rw,size=4k`
to make the container's root filesystem read only

## retrieve hostname

```sh
$ sudo docker exec onion_service cat /onion-service/hostname
abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrst.onion
```

## single-hop mode

in single-hop mode connections from the onion service
to introduction & rendezvous points will be direct
and thus no longer anonymous:
```sh
$ sudo docker run -e NON_ANONYMOUS_SINGLE_HOP_MODE=1 …
```

useful to reduce latency (e.g. clearnet http servers setting `alt-svc` header)

## show circuits

```sh
$ sudo docker exec onion_service \
    sh -c 'printf "AUTHENTICATE\nGETINFO circuit-status\nQUIT\n" | nc localhost 9051'
```
relay search: https://metrics.torproject.org/rs.html

## docker-compose 🐙

1. `git clone https://github.com/fphammerle/docker-onion-service`
2. edit `docker-compose.yml`
3. `sudo docker-compose up --build`

## further reading

[onion service protocol overview](https://community.torproject.org/onion-services/overview/)

[operational security](https://community.torproject.org/onion-services/advanced/opsec/)

### http

ways to publish onion services:
* alt-svc header:
  [cloudflare blog](https://blog.cloudflare.com/cloudflare-onion-service/),
  [privacytools.io](https://write.privacytools.io/jonah/securing-services-with-tor-and-alt-svc),
  [comparison](https://medium.com/@alecmuffett/different-ways-to-add-tor-onion-addresses-to-your-website-39106e2506f9),
  [syntax](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Alt-Svc),
  [spec](https://tools.ietf.org/html/rfc7838)
* onion-location header:
  [apache & nginx setup](https://community.torproject.org/onion-services/advanced/onion-location/),
  [announcement for android](https://blog.torproject.org/comment/288078)
