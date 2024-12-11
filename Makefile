# make preferences
.DELETE_ON_ERROR:
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --warn-undefined-variables
.ONESHELL:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

# Variables
APP_NAME = mock-app
ORG = adrmaas
DATETIME := $(shell date "+%Y-%m-%d_%H-%M-%S")

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

docker-build: ## Builds the basic-app mock Docker container
	docker build --platform linux/amd64 -t "${ORG}/${APP_NAME}:${DATETIME}" .


docker-run: docker-build ## Run basic-app mock local container
	docker run --platform linux/amd64 -p 8080:8080 ${ORG}/${APP_NAME}:${DATETIME}

docker-push: docker-build ## Build, tag, and push mock container to docker hub
	docker push ${ORG}/${APP_NAME}:${DATETIME}
	docker tag ${ORG}/${APP_NAME}:${DATETIME} ${ORG}/${APP_NAME}:latest
	docker push ${ORG}/${APP_NAME}:latest