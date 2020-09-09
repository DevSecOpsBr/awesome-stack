# Jenkins

## Getting Started

Jenkins is an open source automation server written in Java. Jenkins helps to automate the non-human part of the software development process, with continuous integration and facilitating technical aspects of continuous delivery.

### Prerequisites

```
Last version of docker in a swarm mode to using that stack.
```

### Running
```
docker stack deploy -c jenkins.yml ci
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