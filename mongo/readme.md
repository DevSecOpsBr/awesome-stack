# Mongo

## Getting Started

MongoDB is a free and open-source cross-platform document-oriented database program. Classified as a NoSQL database program,

### Prerequisites

```
Last version of docker in a swarm mode to using that stack
```

### Running
```
docker stack deploy -c mongo.yml db
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

To access the Mongo Express UI and see the incomming and outcomming requests type
```
http://<ip_of_your_docker_node>:8081
```

### Authors
Rodrigo Carvalho
DevOps Engineering
Skype: rdgacarvalho