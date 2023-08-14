FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update -y --no-install-recommends

RUN apt-get install \
	vim \
	curl \
	git \
	dialog \
	zsh \
	valgrind \
	dirmngr \
	gpg-agent \
	apt-transport-https \
	net-tools \
	ca-certificates \
	-y --no-install-recommends

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir /root/.gnupg && chmod 700 /root/.gnupg
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/weechat-archive-keyring.gpg --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E

RUN apt-get update

RUN apt-get install \
	weechat-curses \
	weechat-plugins \
	weechat-python \
	weechat-perl \
	irssi \
	-y --no-install-recommends

ENV DEBIAN_FRONTEND=dialog