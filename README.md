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

## retrieve hostname

```sh
$ sudo docker exec onion_service cat /onion-service/hostname
abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrst.onion
```
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
