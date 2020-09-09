# Nginx

## Getting Started

Nginx is a super lightwieght web server able to handle thousands of connections and so on. You can setup your nginx as loadbalancer, cache server or proxy server.

### Prerequisites

```
Last version of docker in a swarm mode to use that stack as well a consul service discovery and a loadbalancer.
You can find boths here.
```

### Running
```
docker stack deploy -c nginx.yml www
```

### Checking
```
docker service ls
```
or
```
docker stack ls
```

### Authors
Rodrigo Carvalho

DevOps Engineering

Skype: rdgacarvalho