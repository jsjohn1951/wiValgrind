#! /bin/bash

docker run -it -w /src --mount type=bind,src="$(pwd)",target=/src wivalgrind-test zsh
docker rm $(printf $(docker ps -a | grep wivalgrind)) $2 > /dev/null