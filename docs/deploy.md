# Deploying services

Docker Stack is a powerful feature of Docker Swarm that allows us to deploy multi-container applications described in a compose file.

---

## Traefik proxy

I am using traefik reverse proxy and load balancer to access docker applications via `domain name` e.g: <http://adminer.docker.local>
<br>Which is very similar on how DNS services like AWS Route53 + AWS ELB works.

> PS: Do not forget to edit /etc/hosts file accordingly. You can use my setup as showed below.

```text
#### Docker Swarm ####
127.0.0.1 traefik.docker.local
127.0.0.1 droneci-runner-exec.docker.local droneci-runner-gh.docker.local droneci-bb.docker.local droneci-gh.docker.local
127.0.0.1 harness.docker.local gitea.docker.local
127.0.0.1 ngrok-bb.docker.loca ngrok-gh.docker.local
127.0.0.1 consul.docker.local vault.docker.local
127.0.0.1 adminer.docker.local portal.docker.local
127.0.0.1 gocd.docker.local prometheus.docker.local
```

### Traefik

[Traefik](https://doc.traefik.io/traefik/) is an open-source Application Proxy that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and identifies which components are responsible for handling them, and routes them securely.

1. **Service Discovery**: Traefik monitors Docker events and identifies services running in the Swarm.
2. **Dynamic Configuration**: Using Docker labels, you define routing rules, middlewares, and other configurations for your services.
3. **Load Balancing**: Traefik routes incoming requests to the appropriate services and balances traffic among instances.

#### Diagram

---

![Traefik Docker Workflow](https://doc.traefik.io/traefik/assets/img/traefik-architecture.png)
*Example: Traefik routing traffic between frontend, backend, and database services.

---

### Service Communication Example

In a typical setup, services communicate through Docker networks:

- **Frontend** (e.g., Traefik) routes traffic to the appropriate backend service.
- **Backend** processes requests and may interact with a database.

*Example: Traffic flow between services within a Docker Swarm cluster.*

---

## Traefik Labels in Docker Compose

Docker labels allow you to configure Traefik dynamically without modifying Traefik’s static configuration. Here’s a brief explanation:

- **`traefik.enable`**: Enable or disable Traefik for the service.
- **`traefik.http.routers.<router-name>.rule`**: Define routing rules (e.g., `Host("example.com")`).
- **`traefik.http.services.<service-name>.loadbalancer.server.port`**: Specify the internal port to route traffic.
- **`traefik.http.middlewares.<middleware-name>`**: Configure middleware (e.g., authentication, headers).

Example Labels in `docker-compose.yml`:

```yaml
services:
  app:
    image: adminer:latest
    deploy:
      replicas: 1
      labels:
        - traefik.enable=true
        - traefik.docker.lbswarm=true
        - traefik.docker.network=docker2docker
        - traefik.http.routers.adminer.entrypoints=web,websecure
        - traefik.http.routers.adminer.rule=Host(`adminer.docker.local`)
        - traefik.http.services.adminer.loadbalancer.server.port=8080
        ...
```

---

## Example Docker Compose File

Here’s an example `dbs.yml` file with the requested configurations:

```yaml
version: '3.9'

services:
  mysql:
    image: docker.io/library/mysql:8
    restart: always
    deploy:
      replicas: 1
      update_config:
          parallelism: 1
          delay: 10s
      restart_policy:
          condition: on-failure
      labels:
        - traefik.enable=false
    env_file:
      - ./.envs/mysql.env
    volumes:
      - mysqld:/var/lib/mysql
    ports:
      - 3306
    networks:
      - docker2docker
    secrets:
      - DOCKER_DB_SECRET

networks:
  docker2docker:
    external: true

secrets:
  DOCKER_DB_SECRET:
    external: true

volumes:
  mysqld:
    external: true
```

---

## Deployment Steps

1. **Deploy the Stack**:`docker stack deploy -c databases/dbs.yml db`
   - **db** means *stack name* which containers uses to talk with each other when need to
2. **Verify the Deployment**:
   - Check services: `docker stack ls`
   - Check logs: `docker service logs db_mysql`
