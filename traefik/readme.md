# Traefik

## Getting Started

Traefik is a reverse proxy / load balancer that's easy, dynamic, automatic, fast, full-featured, open source, production proven, provides metrics, and integrates with every major cluster technologies

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```sh
docker stack deploy -c traefik.yml loadbalancer
```

### Checking

```sh
docker service ls
or
docker stack ls
```

### Dashboard UI

To access traefik dashboard just open your browser and type

```url
http://<ip_your_docker_node>:8080
```

You'll see all providers, frontends and backends of your applications.

After deployed traefik please deploy consul and nginx stack to see how traefik works combined with them.
