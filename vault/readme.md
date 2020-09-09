# Vault

## Getting Started

Vault secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing. Vault handles leasing, key revocation, key rolling, and auditing. Through a unified API, users can access an encrypted Key/Value store and network encryption-as-a-service...

### Prerequisites

```
Last version of docker in a swarm mode to using that stack.
```

### Running
```
docker stack deploy -c vault.yml vault
```

### Checking
```
docker service ls
```
or
```
docker stack ls
```

### Unseal vault
To unseal vault just run the command below
```
docker container exec -ti <container-id> vault operator init
```

The output will show you all the keys and token to unseal vault. Save the output in a safe place.
Once you have all information is time to unseal vault follow the steps

```
http://<ip_of_your_docker_node>:8200/ui
```

When asked by the key please provider one by one till be asked by the token. 
Done your vault is unseal and ready to use and completly integrated with consul as storage backend.

### Authors
Rodrigo Carvalho

DevOps Engineering

Skype: rdgacarvalho