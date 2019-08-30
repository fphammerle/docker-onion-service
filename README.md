# docker: tor obfs4 bridge 🐳

Tor bridge running obfs4 obfuscation protocol in Alpine

alpine port of https://dip.torproject.org/torproject/anti-censorship/docker-obfs4-bridge

## usage

select a random `$OR_PORT` and `$PT_PORT`

(see `/proc/sys/net/ipv4/ip_local_port_range` for range)

```sh
docker run --name tor_obfs4_bridge \
    -e OR_PORT=42218 -p 42218:42218 \
    -e PT_PORT=51804 -p 51804:51804 \
    -e CONTACT_INFO=admin@optional.com \
    fphammerle/tor-obfs4-bridge
```

# further reading

https://community.torproject.org/relay/setup/bridge/
