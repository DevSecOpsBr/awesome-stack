# Traefik

## Getting Started

Traefik is a reverse proxy / load balancer that's easy, dynamic, automatic, fast, full-featured, open source, production proven, provides metrics, and integrates with every major cluster technologies

### Prerequisites

```
Last version of docker in a swarm mode to using that stack.
```

### Running
```
docker stack deploy -c traefik.yml lb
```

### Checking
```
docker service ls
```
or
```
docker stack ls
```

### WebUI
To access traefik dashboard just open your browser and type
```
http://<ip_your_docker_node>:8080
```

You'll see all providers, frontends and backends of your applications. 
After deployed traefik please deploy consul and nginx stack to see how traefik works combined with them. 

### Authors
Rodrigo Carvalho

DevOps Engineering

Skype: rdgacarvalho