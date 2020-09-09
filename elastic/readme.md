# Elastic Stack

## Getting Started

Elastic Stack lets you reliably and securely take data from any source, in any format, and search, analyze, and visualize it in real time.

Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases. 

Kibana lets you visualize your Elasticsearch data and navigate the Elastic Stack, so you can do anything from learning why you're getting paged at 2:00 a.m. to understanding the impact rain might have on your quarterly numbers.

Logstash is an open source, server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite “stash.”

### Prerequisites

```
Last version of docker in a swarm mode to using that stack.
```

### Running
```
docker stack deploy -c elk.yml elk
```

### Checking stack
```
docker service ls
```
or
```
docker stack ls
```

### Checking elasticsearch
```
curl http://<ip_of_your_docker_node>:9200/_cat/health?v
curl http://<ip_of_your_docker_node>:9200/_cat/nodes?v
```

### Checking Kibana
Open your browser and access the url
```
http://<ip_of_your_docker_node>:5601
```

### Authors
Rodrigo Carvalho
DevOps Engineering
Skype: rdgacarvalho