FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

# Add bullseye-backports for newer Python
RUN echo "deb http://deb.debian.org/debian bullseye-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-get update -y --no-install-recommends

# Install Python 3.10 from backports and all required packages (REMOVE old python3/python3-pip here)
RUN apt-get install -y --no-install-recommends \
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
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip

# Optionally create 'python3' symlink to python3.10 so 'python3' calls python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Make pip3 point to python3.10-pip (should already be the case, but for safety)
RUN python3.10 -m pip install --upgrade pip setuptools

# Use python3.10 explicitly for pip installs
RUN python3.10 -m pip install norminette

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mkdir /root/.gnupg && chmod 700 /root/.gnupg
RUN mkdir -p /etc/apt/keyrings
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/weechat-archive-keyring.gpg --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

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