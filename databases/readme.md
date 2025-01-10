# Databases

## Getting Started

MySQL is an open-source relational database management system.

PostgreSQL, often simply Postgres, is an object-relational database management system with an emphasis on extensibility and standards compliance

Adminer is a tool for managing content in MySQL databases. Adminer is distributed under Apache license in a form of a single PHP file.

### Prerequisites

* docker ce
* docker cli
* docker swarm cluster (already setup)

### Stack

---

That stack contain an adminer service to manager your mysql and postgres using an WebUI
MySQL server with a simple setup to support your applications to persist data onto.
PostgreSQL server with a simple setup to support your applications to persist data onto.

### Running

---

```(shell)
docker stack deploy -c dbs.yml db
```

### Checking

```(shell)
docker service ls

or

docker stack ls
```
