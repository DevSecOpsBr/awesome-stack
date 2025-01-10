# Mongo

## Getting Started

MongoDB is a free and open-source cross-platform document-oriented database program. Classified as a NoSQL database program,

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (alread setup)

### Running

```sh
docker stack deploy -c mongo.yml db
```

### Checking

```sh
docker service ls
or
docker stack ls
```

### WebUI

To access the Mongo Express UI and see the incomming and outcomming requests type

```url
http://<ip_of_your_docker_node>:8081
```
