IMAGE_NAME = docker.io/fphammerle/onion-service
PROJECT_VERSION = $(shell git describe --match=v* --abbrev=0 --dirty | sed -e 's/^v//')
TOR_PACKAGE_VERSION = $(shell grep -Po 'TOR_PACKAGE_VERSION=\K.+' Dockerfile | tr -d -)
ARCH = $(shell arch)
# architecture[arm_variant]
# https://github.com/opencontainers/image-spec/blob/v1.0.1/image-index.md#image-index-property-descriptions
IMAGE_TAG_ARCH_aarch64 = arm64
IMAGE_TAG_ARCH_armv6l = armv6
IMAGE_TAG_ARCH_armv7l = armv7
IMAGE_TAG_ARCH_x86_64 = amd64
IMAGE_TAG_ARCH = ${IMAGE_TAG_ARCH_${ARCH}}
IMAGE_TAG = ${PROJECT_VERSION}-tor${TOR_PACKAGE_VERSION}-${IMAGE_TAG_ARCH}
BUILD_PARAMS = --tag="${IMAGE_NAME}:${IMAGE_TAG}" \
	--build-arg=REVISION="$(shell git rev-parse HEAD)"

.PHONY: worktree-clean docker-build podman-build docker-push

worktree-clean:
	git diff --exit-code
	git diff --staged --exit-code

docker-build: worktree-clean
	sudo docker build ${BUILD_PARAMS} .

podman-build: worktree-clean
	# --format=oci (default) not fully supported by hub.docker.com
	# https://github.com/docker/hub-feedback/issues/1871#issuecomment-748924149
	podman build --format=docker ${BUILD_PARAMS} .

docker-push: docker-build
	sudo docker push "${IMAGE_NAME}:${IMAGE_TAG}"
	@echo git tag --sign --message '$(shell sudo docker image inspect --format '{{join .RepoDigests "\n"}}' "${IMAGE_NAME}:${IMAGE_TAG}")' docker/${IMAGE_TAG} $(shell git rev-parse HEAD)
