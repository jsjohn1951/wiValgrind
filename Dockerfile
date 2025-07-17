FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
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
    ca-certificates \
    nodejs \
    irssi \
    && rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN pip install --upgrade pip setuptools norminette

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mkdir /root/.gnupg && chmod 700 /root/.gnupg
RUN mkdir -p /etc/apt/keyrings
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/weechat-archive-keyring.gpg --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    weechat-curses \
    weechat-plugins \
    weechat-python \
    weechat-perl

RUN echo 'alias cc="gcc"' >> ~/.zshrc
RUN echo 'alias c++="g++"' >> ~/.zshrc