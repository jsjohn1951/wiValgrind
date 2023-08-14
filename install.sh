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

if [ "$dockInst" = "n" ];
	then
	echo
	tput setaf 1
	echo "Tough luck 💀 install docker first"
	tput init
	exit 1
fi

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

if [ "$gitInst" = "n" ];
	then
	echo
	tput setaf 1
	echo "Tough luck 💀 install git first"
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

if [ "$gitInst" = "n" ];
	then
	echo
	tput setaf 1
	echo "Tough luck 💀 install git first"
	tput init
	exit 1
fi

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
	if [ "$zshInst" = "y" ]; then
		echo "Aliasing wistart inside .zshrc"

		cat ~/.zshrc | grep wistart $2 > /dev/null
		if [ "$(printf $?)" = "1" ]; then
			echo 'alias wistart="~/wiValgrind/start.sh"' >> ~/.zshrc
		fi

	else
		echo "Aliasing wistart inside .bashrc"

		cat ~/.bashrc | grep wistart $2 > /dev/null
		if [ "$(printf $?)" = "1" ]; then
			echo 'alias wistart="~/wiValgrind/start.sh"' >> ~/.bashrc
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
	echo "Good news, your image is built!"
	tput init
	echo "Nothing to do in install."

	echo
	echo "Open a new terminal to test"
	printf "Run '"
	tput setaf 2
	printf "wistart"
	tput init
	printf "' within working directory!\n"

else
	tput setaf 2
	echo
	echo "Good news, image already built!"
	tput init
	echo "Nothing to do in install."
fi