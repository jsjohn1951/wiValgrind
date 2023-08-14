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
	ca-certificates \
	-y --no-install-recommends

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ENV DEBIAN_FRONTEND=dialog