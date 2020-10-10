# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- ansible playbook: limit container's cpu usage

### Changed
- healthcheck: probe [network-liveness](https://gitweb.torproject.org/torspec.git/tree/control-spec.txt)
  instead of tcp scanning via socks proxy
- changed log level of `control` domain to `warn`
  (to avoid log spam by healthcheck connecting to control listener)
- added message domains to log messages

### Removed
- disabled socks proxy
- `netcat-openbsd` package
  (busybox implementation sufficient for new healthcheck)

## [2.0.0] - 2020-10-01
### Added
- create mount point at `/var/lib/tor`
  to be able to make container's root filesystem read-only

### Changed
- moved tor's data directory from `/home/onion/.tor` to `/var/lib/tor`
- run `tor` as user `tor` (uid=100) instead of `onion` (uid=101)
- docker-compose & ansible-playbook: read-only root filesystem

### Fixed
- docker-compose & ansible-playbook: drop capabilities

## [1.1.0] - 2020-10-01
### Added
- enable [tor control](https://gitweb.torproject.org/torspec.git/tree/control-spec.txt)
  listener on port `9051`
  (listening on loopback device only)

### Fixed
- reduced number of image layers

## [1.0.1] - 2020-02-22
### Fixed
- reduced number of image layers
- upgrade default tor version: 0.3.5.8 -> 0.4.1.7
  (no apparent breaking changes relevant for this image)

## [1.0.0] - 2019-12-29
### Added
- healthcheck via `nc`
- enable hardware acceleration if available
- sample ansible playbook
- sample `docker-compose.yml`

### Fixes
- split `COPY --chown` into `COPY` & `RUN chmod`
  to improve backward compatibility
- upgrade default tor version: v0.3.3.7 -> v0.3.5.8
  ( https://gitweb.torproject.org/tor.git/plain/ChangeLog )

## [0.2] - 2019-01-03
### Changed
- create v3 service (previously v2)

### Added
- option to create v2 service by setting `$VERSION`
  (`docker run -e VERSION=2 …`)

## [0.1] - 2018-12-27

[Unreleased]: https://github.com/fphammerle/docker-onion-service/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/fphammerle/docker-onion-service/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/fphammerle/docker-onion-service/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/fphammerle/docker-onion-service/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/fphammerle/docker-onion-service/compare/0.2-tor0.3.3.7-amd64...v1.0.0
[0.2]: https://github.com/fphammerle/docker-onion-service/compare/0.1-tor0.3.3.7-amd64...0.2-tor0.3.3.7-amd64
[0.1]: https://github.com/fphammerle/docker-onion-service/tree/0.1-tor0.3.3.7-amd64
