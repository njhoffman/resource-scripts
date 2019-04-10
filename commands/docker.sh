#!/bin/bash

#docker
# ~/.docker/machine/machines/default
docker-machine create
docker-machine ls
docker-machine env default
eval "$(docker-machine env default)"
docker login -u admin -p $DOCKER_PASS -e admin@proofme.com docker-registry.proofme.com
docker images
docker ps
docker run hello-world

docker logs <container id> # print output
docker build -t nhoffman/es-navigator .
docker exec -it <container id> /bin/bash #enter the container
# debug a crashing container
docker commit <container_id> broken-container && docker run -it broken-container /bin/bash

docker run -v /Users/$USER/projects/es-navigator/lib:/usr/src/app/lib -p 9200:9200 es-navigator
docker run --privileged ivotron/perf:latest stat sleep 5
docker run --privileged -v /Users/$USER/tmp:/tmp -it --link <container id> ivotron/perf record -F 99 -a -g -o /tmp/myperf.data -- sleep 30
docker run --privileged -v /Users/$USER/tmp:/tmp -it --link <container id> ivotron/perf record -F 99 -p `pgrep -n node` -g -o /tmp/myperf.data -- sleep 30
docker run --privileged -v /Users/$USER/tmp:/tmp -it ivotron/perf report -n --stdio --input=/tmp/myperf.data -f --header

docker run --rm appropriate/curl -fsSL https://www.google.com
docker run --rm -it --link <container id> appropriate/curl curl server:9200

# list listening ports on docker machine
docker-machine ssh default 'sudo netstat -atp tcp | grep -i "listen"'

# docker file config change
RUN echo 'network.host: _non_loopback_' >> /usr/share/elasticsearch/config/elasticsearch.yml

# docker clean up
docker ps -a | grep 'hours ago' | awk '{print $1}' | xargs docker rm
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi

FROM docker-registry-2.proofme.com/proofme-tasks-worker-base:0.3.7

$ docker run \
  -e "NODE_ENV=production" \
  -u "app" \
  -m "300M" --memory-swap "1G" \
  -w "/usr/src/app" \
  --name "my-nodejs-app" \
  node [script]

docker run -h vbox-macosx \
  -v /Users/$USER/projects/proofme/tasks:/var/proofme/tasks \
  -v /Users/$USER/projects/proofme/queue:/var/proofme/queue \
  -v /Users/$USER/projects/proofme/config:/var/proofme/config \
  -i -p 3000 -p 11211 -p 8098 -p 9444 -t proofme-tasks '/bin/bash'
