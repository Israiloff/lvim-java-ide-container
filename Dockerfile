ARG PYTHON_VERSION=3

FROM python:${PYTHON_VERSION}-alpine

ENV JDK_VERSION=21
ENV MAVEN_VERSION=3.9.6
ENV NVM_VERSION=0.39.7

RUN apk add --no-cache bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apk update --no-cache
RUN apk upgrade --no-cache
RUN apk add --no-cache --no-interactive zip
RUN apk add --no-cache --no-interactive unzip
RUN apk add --no-cache --no-interactive curl
RUN apk add --no-cache --no-interactive dpkg
RUN curl -O https://download.oracle.com/java/${JDK_VERSION}/latest/jdk-${JDK_VERSION}_linux-x64_bin.deb
RUN dpkg --add-architecture amd64
RUN dpkg -i jdk-${JDK_VERSION}_linux-x64_bin.deb
RUN rm jdk-${JDK_VERSION}_linux-x64_bin.deb
RUN curl -O https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN tar -xvf apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN mv apache-maven-${MAVEN_VERSION} /opt/
RUN M2_HOME='/opt/apache-maven-${MAVEN_VERSION}' && PATH="\$M2_HOME/bin:\$PATH" && export PATH
RUN rm apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN apk add --no-cache --no-interactive make
RUN apk add --no-cache --no-interactive ca-certificates
RUN apk add --no-cache --no-interactive git
RUN apk add --no-cache --no-interactive g++
RUN apk add --no-cache --no-interactive openssl
RUN apk add --no-cache libstdc++; \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash; \
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
