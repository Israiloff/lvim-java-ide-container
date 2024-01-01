ARG PYTHON_VERSION=3

FROM python:${PYTHON_VERSION}-alpine

ENV JDK_VERSION=21
ENV NVM_VERSION=0.39.7
ENV HOME_DIR=root

RUN apk add --no-cache bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apk update --no-cache
RUN apk upgrade --no-cache
RUN apk add --no-cache --no-interactive zip
RUN apk add --no-cache --no-interactive unzip
RUN apk add --no-cache --no-interactive curl
RUN apk add --no-cache --no-interactive dpkg
RUN apk add --no-cache --no-interactive openjdk${JDK_VERSION}
RUN apk add --no-cache --no-interactive maven
RUN apk add --no-cache --no-interactive make
RUN apk add --no-cache --no-interactive ca-certificates
RUN apk add --no-cache --no-interactive git
RUN apk add --no-cache --no-interactive g++
RUN apk add --no-cache --no-interactive openssl
RUN apk add --no-cache libstdc++
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
RUN echo "source ${HOME_DIR}/.profile;" >> ${HOME_DIR}/.bashrc
RUN echo "export NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release;" >> ${HOME_DIR}/.profile
RUN echo "nvm_get_arch() { nvm_echo \"x64-musl\"; }" >> ${HOME_DIR}/.profile
RUN NVM_DIR="${HOME_DIR}/.nvm"
RUN source ${HOME_DIR}/.nvm/nvm.sh
RUN source ${HOME_DIR}/.profile
RUN nvm install --lts | bash
RUN apk add --no-cache rust
RUN apk add --no-cache cargo
RUN cargo install ripgrep fd-find
RUN apk add gcompat
RUN apk add neovim
RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
RUN echo "alias lvim=${HOME_DIR}/.local/bin/lvim" >> ${HOME_DIR}/.bashrc
RUN rm -r ${HOME_DIR}/.config/lvim
RUN git clone https://github.com/Israiloff/lvim-java-ide.git ${HOME_DIR}/.config/lvim/
RUN git clone https://github.com/eclipse-jdtls/eclipse.jdt.ls.git ~/projects/nvim/jdtls/
RUN ./root/projects/nvim/jdtls/mvnw clean verify -DskipTests=true
