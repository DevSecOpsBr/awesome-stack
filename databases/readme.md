# Databases

## Getting Started

MySQL is an open-source relational database management system. 
PostgreSQL, often simply Postgres, is an object-relational database management system with an emphasis on extensibility and standards compliance
Adminer is a tool for managing content in MySQL databases. Adminer is distributed under Apache license in a form of a single PHP file.

### Prerequisites

```
Last version of docker in a swarm mode to using that stack
```

### Stack
That stack contain an adminer service to manager your mysql and postgres using an WebUI
MySQL server with a simple setup to support your applications to persist data onto.
PostgreSQL server with a simple setup to support your applications to persist data onto.

### Running
```
docker stack deploy -c dbs.yml db
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