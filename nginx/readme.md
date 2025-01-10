# Nginx

## Getting Started

Nginx is a super lightwieght web server able to handle thousands of connections and so on. You can setup your nginx as loadbalancer, cache server or proxy server.

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```sh
docker stack deploy -c nginx.yml www
```

### Checking

```sh
docker service ls
or
docker stack ls
```
