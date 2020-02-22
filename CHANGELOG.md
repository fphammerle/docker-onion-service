# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/fphammerle/docker-onion-service/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/fphammerle/docker-onion-service/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/fphammerle/docker-onion-service/compare/0.2-tor0.3.3.7-amd64...v1.0.0
[0.2]: https://github.com/fphammerle/docker-onion-service/compare/0.1-tor0.3.3.7-amd64...0.2-tor0.3.3.7-amd64
[0.1]: https://github.com/fphammerle/docker-onion-service/tree/0.1-tor0.3.3.7-amd64
