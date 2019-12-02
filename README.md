# docker: hidden tor .onion service 🐳

repo: https://github.com/fphammerle/docker-onion-service

docker hub: https://hub.docker.com/r/fphammerle/onion-service

signed tags: https://github.com/fphammerle/docker-onion-service/tags

defaults to creating a [v3](https://trac.torproject.org/projects/tor/wiki/doc/NextGenOnions) service

## example 1

```sh
$ docker run --name onion-service \
    -e VIRTUAL_PORT=80 -e TARGET=1.2.3.4:8080 \
    fphammerle/onion-service
```

## example 2

```sh
$ docker create --name onion-service \
    --env VERSION=3 \
    --env VIRTUAL_PORT=80 \
    --env TARGET=1.2.3.4:8080 \
    --volume onion-key:/onion-service \
    --restart unless-stopped \
    --cap-drop all --security-opt no-new-privileges \
    fphammerle/onion-service:latest

$ docker start onion-service
```

## retrieve hostname

```sh
$ docker exec onion-service cat /onion-service/hostname
abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrst.onion
```

## docker-compose 🐙

1. `git clone https://github.com/fphammerle/docker-onion-service`
2. edit `docker-compose.yml`
3. `docker-compose up --build`
