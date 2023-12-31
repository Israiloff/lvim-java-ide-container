ARG JDK_VERSION=21
ARG PYTHON_VERSION=3

FROM python:${PYTHON_VERSION}-alpine

RUN apk add --no-cache bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apk update --no-cache
RUN apk upgrade --no-cache
RUN apk add --no-cache --no-interactive zip
RUN apk add --no-cache --no-interactive unzip
RUN apk add --no-cache --no-interactive curl
RUN apk add --no-cache --no-interactive dpkg
RUN curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
RUN dpkg --add-architecture amd64
RUN dpkg -i jdk-21_linux-x64_bin.deb
RUN rm jdk-21_linux-x64_bin.deb
RUN curl -O https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
RUN tar -xvf apache-maven-3.9.6-bin.tar.gz
RUN mv apache-maven-3.9.6 /opt/
RUN M2_HOME='/opt/apache-maven-3.9.6' && PATH="\$M2_HOME/bin:\$PATH" && export PATH
RUN rm apache-maven-3.9.6-bin.tar.gz
RUN apk add --no-cache --no-interactive make
RUN apk add --no-cache --no-interactive ca-certificates
RUN apk add --no-cache --no-interactive git
RUN apk add --no-cache --no-interactive g++
RUN apk add --no-cache --no-interactive openssl
RUN apk add --no-cache libstdc++; \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; \
    echo 'source $HOME/.profile;' >> $HOME/.bashrc; \
    echo 'export NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release;' >> $HOME/.profile; \
    echo 'nvm_get_arch() { nvm_echo "x64-musl"; }' >> $HOME/.profile; \
    NVM_DIR="$HOME/.nvm"; source $HOME/.nvm/nvm.sh; source $HOME/.profile; \
    nvm install --lts
RUN apk add --no-cache rust cargo
RUN cargo install ripgrep fd-find
RUN apk add gcompat
RUN apk add neovim
RUN adduser -D user

USER user
RUN bash <(curl -s \"https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh\") -y
