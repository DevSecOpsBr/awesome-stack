# Jenkins

## Getting Started

Jenkins is an open source automation server written in Java. Jenkins helps to automate the non-human part of the software development process, with continuous integration and facilitating technical aspects of continuous delivery.

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```(sh)
docker stack deploy -c jenkins.yml ci
```

### Checking

```(sh)
docker service ls
or
docker stack ls
```
