# Consul

## Getting Started

Consul is a distributed service mesh to connect, secure, and configure services across any runtime platform and public or private cloud

### Prerequisites

<<<<<<< HEAD
```
Last version of docker in a swarm mode
You can find an ansible playbook to setup a docker swarm cluster from scratch into ansible repository
```

### Running
```
=======
* docker
* docker cli
* docker swarm cluster (already setup)

### Running

```(shell)
>>>>>>> CU-initial
docker stack deploy -c consul.yml consul
```

### Checking
<<<<<<< HEAD
```
docker service ls
```
or
```
=======

```(shell)
docker service ls
```

or

```(shell)
>>>>>>> CU-initial
docker stack ls
```

### Web UI
<<<<<<< HEAD
You can access the web interface to see your consul cluster and services as well. All new docker containers will be discovery by consul once you use add the environments below
```
=======

You can access the web interface to see your consul cluster and services as well. All new docker containers will be discovery by consul once you use add the environments below

```(text)
>>>>>>> CU-initial
environments:
    SERVICE_NAME: <your_service_here>
    SERVICE_TAGS: <your_tags_here>
```
<<<<<<< HEAD
Accessing the WebUI
```
=======

Accessing the WebUI

```(text)
>>>>>>> CU-initial
http://<ip_of_your_docker_node>:8500
```

### ACL setup

The script below you setup the ACL into consul to protect unauthorized access. I am using traefik such as load balancer you can deploy using my stack [traefik stack](https://github.com/rdgacarvalho/docker/tree/master/traefik).

<<<<<<< HEAD
You don't need restart you server(s) or client(s) even registrator because it's using the same master_token defined already in consul server_bootstrap.

1. Setting ACL
```
=======
You don't need restart you server(s) or client(s) even the registrator because it's using the same master_token defined already in consul server_bootstrap.

1. Setting ACL

```(shell)
>>>>>>> CU-initial
bash acl_consul.sh create_agent_token
```

After the script finish just use the MASTER_TOKEN to access your consul via broswer. Remember I am using traefik so you need edit your hosts file and add consul.ellesmera.com there pointing to localhost.

2. Accessing UI

<<<<<<< HEAD
```
http://consul.ellesmera.com
```

### Authors
Rodrigo Carvalho

DevOps Engineering

Skype: rdgacarvalho
=======
```(text)
http://consul.ellesmera.com
```
>>>>>>> CU-initial
