# Global variables for Makefile targets and resources
RESOURCES := container volume network
STACKS := traefik db portainer
DEVOPS := traefik db droneci ngrok gitea gitness

# Define PHONY targets to ensure they always execute
.PHONY: all check_docker init network secrets deploy ps help

# Default target (shows available parameters)
default: help

# Show available parameters
help:
	@echo "Usage: make [target]"
	@echo "Available targets:"
	@echo "  all            - Run all setup steps"
	@echo "  check_docker   - Verify if Docker is running"
	@echo "  init           - Initialize Docker Swarm"
	@echo "  network        - Create Docker overlay network"
	@echo "  secrets        - Create Docker secret for database password"
	@echo "  deploy         - Deploy essential stacks e.g: LB: traefik, DB: adminer, mysql and postgres, UI: portainer"
	@echo "  devops-stack   - Deploy essential stacks e.g: LB: traefik, DB: adminer, mysql and postgres, Ingress: ngrok, CI/CD: harness, SVC: gitea, Sec: vault"
	@echo "  ps             - Show all running Docker containers"
	@echo "  remove_stacks  - Remove only the stacks defined in this Makefile"
	@echo "\n  🚨 At least one parameter must be provided. 🚨"

# Default target (runs all steps)
all: check_docker init network secrets deploy ps

# Check if Docker is running
check_docker:
	@docker info > /dev/null 2>&1 || (echo "Docker is not running. Please start Docker." && exit 1)
	@echo "⚙️ Docker is running."

# Initialize Docker Swarm (if not already initialized)
init:
	@docker info | grep 'Swarm: active' || docker swarm init
	@echo "🤖 Docker Swarm initialized."

# Create a Docker network with overlay driver and attachable parameter
network:
	@docker network ls | grep 'docker2docker' || docker network create --driver=overlay --attachable docker2docker
	@echo "🎯 Docker network 'docker2docker' created or already exists."

# Create a Docker secret for the database password
secrets:
	@[ -z "$(DOCKER_SECRET_DB)" ] && echo "DOCKER_SECRET_DB is not set" && exit 1 || \
	docker secret ls | grep 'database_password' || echo "$$DOCKER_SECRET_DB" | docker secret create database_password -
	@echo "🔑 Docker secret 'database_password' created or already exists."

# Define the stacks to be deployed

# Deploy multiple stacks, dynamically finding the correct YAML file
deploy: devops-stack
	@for stack in $(STACKS); do \
	  FILE=$$(find $$stack -maxdepth 1 -type f \( -name "*.yml" -o -name "*.yaml" \) | head -n 1); \
	  if [ -n "$$FILE" ]; then \
	    docker stack deploy -c $$FILE $$stack; \
	    echo "🛫 Stack $$stack deployed using $$FILE"; \
	  else \
	    echo "‼️ No YAML file found for $$stack, skipping deployment ‼️"; \
	  fi; \
	done

devops-stack: ps
	@for stack in $(DEVOPS); do \
	  FILE=$$(find $$stack -maxdepth 1 -type f \( -name "*.yml" -o -name "*.yaml" \) | head -n 1); \
	  if [ -n "$$FILE" ]; then \
	    docker stack deploy -c $$FILE $$stack; \
	    echo "🛫 Stack $$stack deployed using $$FILE"; \
	  else \
	    echo "‼️ No YAML file found for $$stack, skipping deployment ‼️"; \
	  fi; \
	done

# Remove only the stacks defined in this Makefile
# Prune unused Docker resources without affecting existing deployments
remove_stacks:

	@for stack in $(STACKS); do \
	  docker stack ls | grep -w $$stack > /dev/null && docker stack rm $$stack && echo "Stack $$stack removed." || echo "Stack $$stack not found, skipping."; \
	done

	@for resources in $(RESOURCES); do \
	  docker $$resources prune -f; \
	done
	@echo "Pruned unused Docker resources."

# Show all running Docker containers
ps:
	docker service ls
	@echo "\n⚙️ Listing all running Docker containers."
