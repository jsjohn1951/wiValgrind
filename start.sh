#! /bin/bash

docker run --name wivalgrind -p 80:80 -p 8080:8080 -it -w /src --mount type=bind,src="$(pwd)",target=/src wivalgrind-test zsh
docker rm $(printf $(docker ps -a | grep wivalgrind)) $2 > /dev/null