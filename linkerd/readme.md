# Linkerd

## Getting Started

Linkerd is a service mesh that adds reliability, security, and visibility to cloud native applications

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```(sh)
docker stack deploy -c linkerd.yml lb
```

### Checking

```(sh)
docker service ls
or
docker stack ls
```

### WebUI

To access the WebUI and see the incomming and outcomming requests type

```(url)
http://<ip_of_your_docker_node>:8080
```
