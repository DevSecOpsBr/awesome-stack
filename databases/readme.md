# Databases

## Getting Started

MySQL is an open-source relational database management system.
<<<<<<< HEAD
PostgreSQL, often simply Postgres, is an object-relational database management system with an emphasis on extensibility and standards compliance
=======

PostgreSQL, often simply Postgres, is an object-relational database management system with an emphasis on extensibility and standards compliance

>>>>>>> CU-initial
Adminer is a tool for managing content in MySQL databases. Adminer is distributed under Apache license in a form of a single PHP file.

### Prerequisites

<<<<<<< HEAD
> Last version of docker in a swarm mode to using that stack

### Stack

=======
* docker ce
* docker cli
* docker swarm cluster (already setup)

### Stack

---

>>>>>>> CU-initial
That stack contain an adminer service to manager your mysql and postgres using an WebUI
MySQL server with a simple setup to support your applications to persist data onto.
PostgreSQL server with a simple setup to support your applications to persist data onto.

### Running

<<<<<<< HEAD
=======
---

>>>>>>> CU-initial
```(shell)
docker stack deploy -c dbs.yml db
```

### Checking

```(shell)
docker service ls
<<<<<<< HEAD
```

or

```(shell)
docker stack ls
```

### Authors

Rodrigo Carvalho
DevOps Engineering
Skype: rdgacarvalho
=======

or

docker stack ls
```
>>>>>>> CU-initial
