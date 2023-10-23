#!/bin/bash

# Check if docker exists on this computer
if ! hash docker &> /dev/null
then
    echo "docker could not be found"
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "   Bdeb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt install docker-ce
    sudo usermod -aG docker ${USER}
    #exit
fi

xhost +

# Make sure b2b directory exists and is git clone of right project
[ -d ./b2b ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2

CONTAINER=kv4

# Make symlink to docker for this dev environment
if [ ! -f Dockerfile ]
then
    cp b2b/gui/kivy/kivyex1/Dockerfile .
fi

#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}
# Init container
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Start Dev container
sudo docker run --privileged  -v${PWD}:/usr/src/app/ --network=host --env="DISPLAY" -p3000:3445    -it ${CONTAINER}  /bin/bash
