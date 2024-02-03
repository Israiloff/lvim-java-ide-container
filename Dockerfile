ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}-alpine

ARG JDK_VERSION

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
RUN apk add --no-cache --no-interactive openjdk${JDK_VERSION}
RUN apk add --no-cache --no-interactive maven
RUN apk add --no-cache --no-interactive make
RUN apk add --no-cache --no-interactive ca-certificates
RUN apk add --no-cache --no-interactive git
RUN apk add --no-cache --no-interactive g++
RUN apk add --no-cache --no-interactive openssl
RUN apk add --no-cache --no-interactive libstdc++
RUN apk add --no-cache --no-interactive npm
RUN apk add --no-cache --no-interactive openssl
RUN apk add --no-cache --no-interactive gcompat
RUN apk add --no-cache --no-interactive neovim
RUN apk add --no-cache --no-interactive fontconfig

#INSTALLING RUSTUP
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install ripgrep fd-find

#INSTALLING LUNARVIM
RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
RUN echo "alias lvim=$HOME/.local/bin/lvim" >> $HOME/.bashrc

#INSTALLING LUNARVIM JAVA IDE CONFIGS
RUN rm -r $HOME/.config/lvim
RUN git clone https://github.com/Israiloff/lvim-java-ide.git $HOME/.config/lvim

#INSTALLING JDTLS
RUN git clone https://github.com/eclipse-jdtls/eclipse.jdt.ls.git $HOME/projects/nvim/jdtls
RUN cd $HOME/projects/nvim/jdtls && ./mvnw clean verify -DskipTests=true

#INSTALLING MICROSOFT JAVA DEBUG FOR VS
RUN git clone https://github.com/microsoft/java-debug $HOME/projects/nvim/java-debug
RUN cd $HOME/projects/nvim/java-debug && ./mvnw clean install

#INSTALLING MICROSOFT JAVA TEST FOR VS
RUN git clone https://github.com/microsoft/vscode-java-test.git $HOME/projects/nvim/java-test
RUN cd $HOME/projects/nvim/java-test && npm install && npm run build-plugin

#DOWNLOADING LOMBOK ANNOTATION PROCESSOR
RUN curl -L https://projectlombok.org/downloads/lombok.jar -o $HOME/projects/nvim/lombok.jar

RUN curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.zip
RUN mkdir /.fonts
RUN unzip RobotoMono.zip -d /.fonts
RUN fc-cache -fv
RUN rm RobotoMono.zip

#UPDATING LUNARVIM CONFIG
RUN . $HOME/.local/bin/lvim +LvimUpdate +LvimCacheReset +q

RUN apk add --no-cache --no-interactive zsh

#CHANGING DEFAULT SHELL TO ZSH
SHELL ["/bin/zsh", "-c"]

#INSTALLING AND CONFIGURING OH MY ZSH
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo "alias lvim=$HOME/.local/bin/lvim" >> $HOME/.zshrc
RUN sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/g' ~/.zshrc
RUN apk add --no-cache --no-interactive zsh-vcs
RUN echo 'export SHELL=/bin/zsh' | sudo tee -a /etc/profile

ENTRYPOINT ["/bin/zsh"]
