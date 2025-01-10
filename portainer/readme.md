# Portainer

## Getting Started

Portainer is a simple management solution for Docker. Easily manage your Docker hosts and Docker Swarm clusters via Portainer web user interface.

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```sh
docker stack deploy -c portainer.yml dc
```

### Checking

```sh
docker service ls
or
docker stack ls
```
