FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update -y --no-install-recommends

RUN apt-get install \
	vim \
	curl \
	git \
	make \
	g++ \
	gcc \
	dialog \
	zsh \
	valgrind \
	dirmngr \
	gpg-agent \
	gnupg \
	gnupg2 \
	apt-transport-https \
	net-tools \
	python3 \
	python3-pip \
	ca-certificates \
	-y --no-install-recommends

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN python3 -m pip install --upgrade pip setuptools
RUN python3 -m pip install norminette
RUN mkdir /root/.gnupg && chmod 700 /root/.gnupg
RUN mkdir -p /etc/apt/keyrings
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/weechat-archive-keyring.gpg --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_21.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update

RUN apt-get install \
	weechat-curses \
	weechat-plugins \
	weechat-python \
	weechat-perl \
	irssi \
	nodejs \
	-y --no-install-recommends

RUN npm install -g firebase-tools

RUN echo 'alias cc="gcc"' >> ~/.zshrc
RUN echo 'alias c++="g++"' >> ~/.zshrc

ENV DEBIAN_FRONTEND=dialog