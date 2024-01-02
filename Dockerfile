ARG PYTHON_VERSION=3

FROM python:${PYTHON_VERSION}-alpine

ENV JDK_VERSION=21
ENV NVM_VERSION=0.39.7
ENV HOME_DIR=root

#PREPARING OS
RUN apk add --no-cache bash
RUN apk update --no-cache
RUN apk upgrade --no-cache

#CHANGING DEFAULT SHELL
SHELL ["/bin/bash", "-c"]

#INSTALLING COMMONS
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

#INSTALLING NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
RUN echo "source ${HOME_DIR}/.profile;" >> ${HOME_DIR}/.bashrc
RUN echo "export NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release;" >> ${HOME_DIR}/.profile
RUN echo "nvm_get_arch() { nvm_echo \"x64-musl\"; }" >> ${HOME_DIR}/.profile
RUN NVM_DIR="${HOME_DIR}/.nvm"
RUN source ${HOME_DIR}/.nvm/nvm.sh
RUN source ${HOME_DIR}/.profile
RUN nvm install --lts | bash
RUN apk add gcompat
RUN apk add neovim

#INSTALLING AND PREPARING RUST
RUN apk add --no-cache rust
RUN apk add --no-cache cargo
RUN cargo install ripgrep fd-find

#INSTALLING LUNARVIM
RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
RUN echo "alias lvim=${HOME_DIR}/.local/bin/lvim" >> ${HOME_DIR}/.bashrc

#INSTALLING LUNARVIM JAVA IDE CONFIGS
RUN rm -r ${HOME_DIR}/.config/lvim
RUN git clone https://github.com/Israiloff/lvim-java-ide.git ${HOME_DIR}/.config/lvim

#INSTALLING JDTLS
RUN git clone https://github.com/eclipse-jdtls/eclipse.jdt.ls.git ${HOME_DIR}/projects/nvim/jdtls
RUN cd ${HOME_DIR}/projects/nvim/jdtls && ./mvnw clean verify -DskipTests=true

#INSTALLING MICROSOFT JAVA DEBUG FOR VS
RUN git clone https://github.com/microsoft/java-debug ${HOME_DIR}/projects/nvim/java-debug
RUN cd ${HOME_DIR}/projects/nvim/java-debug && ./mvnw clean install

#INSTALLING MICROSOFT JAVA TEST FOR VS
RUN git clone https://github.com/microsoft/vscode-java-test.git ${HOME_DIR}/projects/nvim/java-test
RUN cd ${HOME_DIR}/projects/nvim/java-test && npm run build-plugin

#DOWNLOADING LOMBOK ANNOTATION PROCESSOR
RUN curl -o ${HOME_DIR}/projects/nvim/lombok.jar https://projectlombok.org/downloads/lombok.jar

CMD ["bash"]
