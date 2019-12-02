# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- tor v0.3.3.7 -> v0.3.5.8

### Added
- healthcheck via `nc`
- enable hardware acceleration if available
- sample ansible playbook
- sample `docker-compose.yml`

### Fixes
- split `COPY --chown` into `COPY` & `RUN chmod`
  to improve backward compatibility

## 0.2 - 2019-01-03
### Changed
- create v3 service (previously v2)

### Added
- option to create v2 service by setting `$VERSION`
  (`docker run -e VERSION=2 …`)

## 0.1 - 2018-12-27

[Unreleased]: https://github.com/fphammerle/docker-onion-service/compare/0.2-tor0.3.3.7-amd64...HEAD
