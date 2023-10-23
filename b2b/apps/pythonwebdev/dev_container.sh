#!/bin/bash

CONTAINER=pyw1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}

docker build -t ${CONTAINER} .

docker run --privileged -it --rm -v $PWD:/data  --net=host ${CONTAINER} /bin/bash
