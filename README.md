# Docker

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

<<<<<<< HEAD
## Welcome to my repository

Here you'll find some Docker Compose files to use in a production environment Docker Swarm Cluster

The main goal is show the best practices and try create a stable and realiable environment that we can.

## Docker swarm & network

Initialize docker swarm cluster

```(shell)
docker swarm init
docker swarm join ...
```

Create a docker2docker network to allow comminication between containers

```(shell)
docker network create docker2docker --subnet 10.1.0.1/16 --driver overlay --attachable
```

## Age section

age is a simple, modern and secure file encryption tool, format, and Go library.

It features small explicit keys, no config options, and UNIX-style composability.

```(shell)
$ age-keygen -o key.txt
Public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p
$ tar cvz ~/data | age -r age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p > data.tar.gz.age
$ age --decrypt -i key.txt data.tar.gz.age > data.tar.gz
```

### Ecrypting files

The below command find for files ending with `.env` under `.secrets` folder(only) encrypting and remove it afterwards.

```(shell)
for s in $(find . -type f -print -execdir .secrets {} \; | egrep ".env$"); do age -e -R ~/.ssh/id_rsa.pub -o $s.age $s && rm $s; done
```

#### Decrypting files

The below command find for files ending with `.age` under `.secrets` folder(only) decrypting it.

```(shell)
for s in $(find * -type f -print -execdir secrets {} +); do age -d -i ~/.ssh/id_rsa -o $(ls $s | awk -F '.' '{ print $1}')\.env $s ; done
```
=======
## Welcome to my Docker repository

Here you'll find some Docker compose files to use in your local  environment by setting a Docker Swarm cluster. Which I prefer in order to have a near cluster concept such as managers and nodes.

The main goal is to show the best practices and try create a stable and realiable environment that we can use for DevSecOps purposal.

## Pre-requistes

1. [Docker CE](https://docs.docker.com/get-started/get-docker/)
2. [docker-compose](https://docs.docker.com/compose/install/standalone/) cli

* Once you have met all the above requisites move forward to documentation section

### Documentation

---

- [Setup](https://github.com/DevSecOpsBr/docker/blob/master/docs/setup.md) environment
- [Deploying](https://github.com/DevSecOpsBr/docker/blob/master/docs/deploy.md) services
- [Encrypting](https://github.com/DevSecOpsBr/docker/blob/master/docs/age.md) data with age

### My stacks

My stack list is described below. I am often adding new stack to it and also testing and/or validating new related DevSecOps services.

* concourse
* consul
* databases
* droneci
* elastic
* flask
* gitea
* gitness
* gocd
* gogs
* haproxy
* jenkins
* linkerd
* localstack
* mongo
* nginx
* ngrok
* openstack
* portainer
* prometheus
* teamcity
* traefik
* vault
* webhookrelay

---

You are more then welcome to contribute and add new services stack.

`Fork me!`
>>>>>>> CU-initial
