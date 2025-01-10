# Setup environment

I will use docker swarm and follow a cluster concept (when possible).

## Creating a docker swarm cluster

To create a docker swarm cluster execute below commands in your favorite terminal

```(shell)
docker swarm init && \
docker node ls && \
docker ps
```

> Great! The swarm cluster is setting up!

If you haven't faced any issue and all above commands worked as expected move forward to next section

---

#### Creating a docker network

Docker allow us to create _overlay_ networks this creating some communication isolation between container(s). Secondly, advantage is the capability to talk with another containers using their service names (I will show some examples later on).

Let's create a docker2docker network to allow comminication between containers **only** in this network by running below command in the terminal.

```(shell)
docker network create docker2docker --subnet 10.1.0.1/16 --driver overlay --attachable && \
docker network ls | grep docker2docker
```

---

### Secrets in docker

One of the great features of docker is manager **secrets** to keep sensitive data such as passwords, tokens, credentials, certificates _encrpyted_.
There are many ways and tools to be used for managing secrets but let's use docker secrets manager for now.

To make it easier creating, managing, updating secrets I am following below strategy.

1. Use openssl to generate one time secret
   1. openssl rand -base64 15
2. Store the secret in .bashrc or .zshrc an environment variable and export
   1. Edit .bashrc or .zshrc depending of the current **shell** checking by run (echo $SHELL)
   2. echo "export DOCKER_DB_SECRET=\"$(openssl rand -base64 15)\"" | tee -a $HOME/.zshrc
3. Create and store DOCKER_DB_SECRET in docker secret manager

Run bellow command lines to setup all the steps automatically

```(shell)
echo "export DOCKER_DB_SECRET=\"$(openssl rand -base64 15)\"" | tee -a $HOME/.zshrc && \
printenv DOCKER_SECRET_ALL_IN_ONE | docker secret create docker_db_secret - && \
source $HOME/.zshrc
```

* Verifying secret was created

```(shell)
docker secret ls
```

output:

```sh
ID                          NAME                DRIVER    CREATED          UPDATED
ie6wir6bv5tt2b20zu1abm8gz   database_password             21 minutes ago   21 minutes ago
```

> Awesome! Docker secret has been created

Next: [Deploying services](https://github.com/DevSecOpsBr/docker/blob/master/docs/deploy.md)
