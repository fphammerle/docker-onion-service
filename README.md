# docker: tor socks & dns proxy 🌐 🐳

docker hub: https://hub.docker.com/r/fphammerle/tor-proxy

signed tags: https://github.com/fphammerle/tor-proxy/tags

```sh
$ docker run --rm --name tor-proxy \
    -p 127.0.0.1:9050:9050/tcp \
    -p 127.0.0.1:53:53/udp \
    fphammerle/tor-proxy
```

or after cloning the repository 🐙
```sh
$ docker-compose up
```

test proxies:
```sh
$ curl --socks5 localhost:9050 ipinfo.io
$ torsocks wget -O - ipinfo.io
$ torsocks lynx -dump https://check.torproject.org/
$ dig @localhost fabian.hammerle.me
$ ssh -o 'ProxyCommand nc -x localhost:9050 -v %h %p' abcdefghi.onion
# no anonymity!
$ chromium-browser --proxy-server=socks5://localhost:9050 ipinfo.io
```
