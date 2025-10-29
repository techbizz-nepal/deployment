# Default target
.DEFAULT_GOAL := help

# Colors for help messages
CYAN := \033[36m
NC := \033[0m

# Compose commands
DOCKER_COMPOSE = docker compose

# Main targets
up: ## Start prod stack (docker-compose.yaml)
	$(DOCKER_COMPOSE) -f docker-compose.yaml up -d

down: ## Stop prod stack
	$(DOCKER_COMPOSE) -f docker-compose.yaml down

logs: ## Tail logs from prod stack
	$(DOCKER_COMPOSE) -f docker-compose.yaml logs -f

up-dev: ## Start dev stack (with override if exists)
	@if [ -f docker-compose.override.yaml ]; then \
		$(DOCKER_COMPOSE) -f docker-compose-dev.yaml -f docker-compose.override.yaml up; \
	else \
		$(DOCKER_COMPOSE) -f docker-compose-dev.yaml up; \
	fi

down-dev: ## Stop dev stack
	$(DOCKER_COMPOSE) -f docker-compose-dev.yaml down

logs-dev: ## Tail logs from dev stack
	$(DOCKER_COMPOSE) -f docker-compose-dev.yaml logs -f

exec: ## Execute container
	$(DOCKER_COMPOSE) exec 

help: ## Show this help
	@echo "$(CYAN)Available commands:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
