# Linkerd

## Getting Started

Linkerd is a service mesh that adds reliability, security, and visibility to cloud native applications

### Prerequisites

```
Last version of docker in a swarm mode to using that stack
```

### Running
```
docker stack deploy -c linkerd.yml lb
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

To access the WebUI and see the incomming and outcomming requests type
```
http://<ip_of_your_docker_node>:8080
```

### Authors
Rodrigo Carvalho
DevOps Engineering
Skype: rdgacarvalho