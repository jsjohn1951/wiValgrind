#! /bin/bash


tput setaf 2; printf "         _nnnn_                      \n"
tput setaf 2; printf "        dGGGGMMb     ,''''''''''''''.\n"
tput setaf 2; printf "       @p~qp~~qMb    | Linux Rules! |\n"
tput setaf 2; printf "       M|@||@) M|   _;..............'\n"
tput setaf 2; printf "       @,----.JM| -'                 \n"
tput setaf 2; printf "      JS^\__/  qKL     "; tput setaf 1; printf " __      __.______   ____      .__                .__            .___._.\n"
tput setaf 2; printf "     dZP        qKRb   "; tput setaf 1; printf "/  \\    /  \\__\\   \\ /   /____  |  |    ___________|__| ____    __| _/| |\n"
tput setaf 2; printf "    dZP          qKKb  "; tput setaf 1; printf "\\   \\/\\/   /  |\\   Y   /\\__  \\ |  |   / ___\\_  __ \\  |/    \\  / __ | | |\n"
tput setaf 2; printf "   fZP            SMMb "; tput setaf 1; printf " \\        /|  | \\     /  / __ \\|  |__/ /_/  >  | \\/  |   |  \\/ /_/ |  \\|\n"
tput setaf 2; printf "   HZM            MMMM "; tput setaf 1; printf "  \\__/\\  / |__|  \\___/  (____  /____/\\___  /|__|  |__|___|  /\\____ |  __\n"
tput setaf 2; printf "   FqM            MMMM "; tput setaf 1; printf "       \\/                    \\/     /_____/               \\/      \\/  \\/\n"
tput setaf 2; printf " __|  .        |\dS qML              \n"
tput setaf 2; printf " |     .       |  ' \Zq              \n"
tput setaf 2; printf "_)      \.___.,|     .'              \n"
tput setaf 2; printf "\____   )MMMMMM|   .'                \n"
tput setaf 2; printf "      -'        --' hjm              \n\n"
tput init

echo

printf "Installing on a 42 lab machine? ("
tput setaf 2
printf " y"
tput init
printf "/"
tput setaf 1
printf "n "
tput init
printf ") "
read fortyTwoLab

printf "Is docker installed? ("
tput setaf 2
printf " y"
tput init
printf "/"
tput setaf 1
printf "n "
tput init
printf ") "
read dockInst

if [ "$dockInst" = "n" ] || [ "$dockInst" = "N" ];
	then
	echo
	tput setaf 1
	echo "Tough luck 💀 install docker first"
	tput init
	exit 1
fi


if [ "$fortyTwoLab" == "y" ] || [ "$fortyTwoLab" == "Y" ];
	then
	echo
	if [ "$(docker ps)" ];
		then
		tput setaf 1
        echo "Docker is running. Let's kill it first 🔫"
        test -z "$(docker ps -q 2>/dev/null)" && osascript -e 'quit app "Docker"'
        sleep 1
    fi
	rm -rf ~/goinfre/docker
	mkdir -p ~/goinfre/com.docker.docker
	rm -rf ~/Library/Containers/com.docker.docker
	ln -s ~/goinfre/com.docker.docker ~/Library/Containers/com.docker.docker
	echo "Docker directory setup complete :)"
	sleep 1
	tput setaf 2
	echo "Let's proceed with installation 🤓"
	sleep 1
	tput init
fi

docker ps > /dev/null 2>&1
if [ $? -eq 1 ];
	then
	open -a Docker
	echo "starting docker now 😎"
fi

echo "waiting for docker 🥱"
tput setaf 1
while true;
	do
	docker ps > /dev/null 2>&1
	if [ $? -eq 0 ];
		then
		break
	fi
	printf " ."
	sleep 1
done
tput setaf 2
echo "docker running 😇"
tput init

printf "Is git installed? ("
tput setaf 2
printf " y"
tput init
printf "/"
tput setaf 1
printf "n "
tput init
printf ") "
read gitInst

if [ "$gitInst" = "n" ] || [ "$gitInst" = "N" ];
	then
	echo
	tput setaf 1
	echo "Tough luck 💀 install git first 😱"
	tput init
	exit 1
fi

printf "Are you using zsh? ("
tput setaf 2
printf " y"
tput init
printf "/"
tput setaf 1
printf "n "
tput init
printf ") "
read zshInst

docker images | grep wivalgrind $2 > /dev/null

if [ "$(printf $?)" = "1" ]; then
	echo "Cloning wiValgrind in root."

	ls ~/wiValgrind $2 > /dev/null

	if [ "$(printf $?)" = "1" ]; then
		git -C ~/ clone https://github.com/jsjohn1951/wiValgrind.git
	else
		git -C ~/wiValgrind pull
	fi

	tput setaf 1
	if [ "$zshInst" = "y" ] || [ "$zshInst" = "Y" ]; then
		echo "Aliasing dev inside .zshrc"

		cat ~/.zshrc | grep dev $2 > /dev/null
		if [ "$(printf $?)" = "1" ]; then
			echo 'alias dev="~/wiValgrind/start.sh"' >> ~/.zshrc
		fi

	else
		echo "Aliasing dev inside .bashrc"

		cat ~/.bashrc | grep dev $2 > /dev/null
		if [ "$(printf $?)" = "1" ]; then
			echo 'alias dev="~/wiValgrind/start.sh"' >> ~/.bashrc
		fi

	fi
	tput init

	path=$PWD

	cd ~/wiValgrind
	docker compose -f ~/wiValgrind/docker-compose.yml up -d --build
	docker rm $(printf $(docker ps -a | grep wivalgrind)) $2 > /dev/null

	cd $path

	tput setaf 2
	echo
	echo "Good news, your image is built! 🥳"
	tput init
	echo "Nothing to do in install."

	echo
	echo "Open a new terminal 🤖 to test "
	printf "Run '"
	tput setaf 2
	printf "dev"
	tput init
	printf "' within working directory!\n"

else
	tput setaf 2
	echo
	echo "Good news, image already built!"
	tput init
	echo "Nothing to do in install."
fi