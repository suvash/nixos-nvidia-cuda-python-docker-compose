.DEFAULT_GOAL:=build
SHELL:=/usr/bin/env bash

DOCKER_REPOSITORY=docker.io
REPO_USERNAME=suvash

IMAGE_PREFIX:=$(DOCKER_REPOSITORY)/$(REPO_USERNAME)

SHA_HEAD:=$(shell git rev-parse --short HEAD)
DATE_NOW:=$(shell date +%Y-%m-%dT%H:%M:%S%z)

DEEPLIBS_NAME:=deeplibs
DEEPLIBS_TAG_PREFIX:=py3.7-cuda11.1-ubuntu20.04
DEEPLIBS_FOLDER:=$(DEEPLIBS_NAME)/$(DEEPLIBS_TAG_PREFIX)
DEEPLIBS_IMAGE:=$(IMAGE_PREFIX)/$(DEEPLIBS_NAME):$(DEEPLIBS_TAG_PREFIX)-$(SHA_HEAD)

# Build section

.PHONY: build build-deeplibs

build: build-deeplibs

build-deeplibs:
	$(info -- Building docker image $(DEEPLIBS_IMAGE))
	docker image build -t $(DEEPLIBS_IMAGE) -f $(DEEPLIBS_FOLDER)/Dockerfile $(DEEPLIBS_FOLDER)

# Clean section

.PHONY: clean clean-deeplibs

clean: clean-deeplibs

clean-deeplibs:
	$(info -- Cleaning docker image $(DEEPLIBS_IMAGE))
	docker image rm $(DEEPLIBS_IMAGE)
