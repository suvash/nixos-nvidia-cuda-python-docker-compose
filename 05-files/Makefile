.DEFAULT_GOAL:=help
SHELL:=/usr/bin/env bash

##@ Help

help:  ## Show this message
	@awk '\
	BEGIN {FS = ":.*##"} \
	/^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
	/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } \
	' $(MAKEFILE_LIST)


export HOST_USER_ID:=$(shell id -u)
export HOST_GROUP_ID:=$(shell id -g)

DOCKER_COMPOSE := docker-compose -f compose.yml
DOCKER_COMPOSE_RUN_LAB := $(DOCKER_COMPOSE) run --rm lab

##@ Building

.PHONY: build

build:  ## Build the docker images
	$(if $(SERVICE_NAME), $(info -- Building $(SERVICE_NAME)), $(info -- Building all services, SERVICE_NAME not set.))
	$(info -- Remember to run `make prune` after a `build` to clean up orphaned image layers)
	$(DOCKER_COMPOSE) build $(SERVICE_NAME)


##@ Start/Stop/Restart

.PHONY: start stop restart

start: ## Start all the project service containers daemonised (Logs are tailed by a separate command)
	$(DOCKER_COMPOSE) up -d

stop: ## Stop all the project service containers
	$(DOCKER_COMPOSE) down --volumes

restart: ## Restart the project service containers (Filtered via SERVICE_NAME, eg. make restart SERVICE_NAME=worker)
	$(if $(SERVICE_NAME), $(info -- Restarting $(SERVICE_NAME)), $(info -- Restarting all services, SERVICE_NAME not set.))
	$(DOCKER_COMPOSE) restart $(SERVICE_NAME)


##@ Logging

.PHONY: logs

logs: ## Tail the logs for the project service containers (Filtered via SERVICE_NAME, eg. make tail-logs SERVICE_NAME=worker)
	$(if $(SERVICE_NAME), $(info -- Tailing logs for $(SERVICE_NAME)), $(info -- Tailing all logs, SERVICE_NAME not set.))
	$(DOCKER_COMPOSE) logs -f $(SERVICE_NAME)


##@ One-off tasks

.PHONY: run-lab

run-lab: ## Run a one-off command in a new lab service container. Specify using CMD (eg. make run-lab CMD=echo something)
	$(if $(CMD), $(DOCKER_COMPOSE_RUN_LAB) $(CMD), $(error -- CMD must be set))

##@ Shell

.PHONY: bash

bash: CMD=conda_bash.sh
bash: run-lab ## Spawn a bash shell for lab service


##@ Cleanup

.PHONY: prune

prune: ## Cleanup dangling/orphaned docker resources
	docker system prune --volumes -f
