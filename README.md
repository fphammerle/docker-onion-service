# docker: hidden tor .onion service

repo: https://github.com/fphammerle/docker-onion-service

docker hub: https://hub.docker.com/r/fphammerle/onion-service

## example 1

```sh
$ docker run --name onion-service \
    -e VIRTUAL_PORT=80 -e TARGET=1.1.1.1:80 \
    fphammerle/onion-service
```

## example 2

```sh
$ docker create --name onion-service \
    --env VIRTUAL_PORT=80 \
    --env TARGET=1.1.1.1:80 \
    --volume onion-key:/onion-service \
    --restart unless-stopped \
    --cap-drop all --security-opt no-new-privileges \
    fphammerle/onion-service:latest

$ docker start onion-service
```

## retrieve hostname

```sh
$ docker exec onion-service cat /onion-service/hostname
abcdefghijklmnop.onion
```
