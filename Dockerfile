FROM python:latest

RUN /bin/bash -c "apt update -y"
RUN /bin/bash -c "apt upgrade -y"
RUN /bin/bash -c "adduser user"

USER user

RUN /bin/bash -c "apt install -y zip"
RUN /bin/bash -c "apt install -y unzip"
RUN /bin/bash -c "apt install -y openjdk-17-jdk"
RUN /bin/bash -c "apt install -y maven"
RUN /bin/bash -c "apt install -y make"
RUN /bin/bash -c "apt install -y build-essential"
RUN /bin/bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
RUN /bin/bash -c "source ~/.nvm/nvm.sh"
RUN /bin/bash -c "nvm install --lts"
RUN /bin/bash -c "curl https://sh.rustup.rs -sSf | sh -s -- -y"
RUN /bin/bash -c "source \"$HOME/.cargo/env\""
RUN /bin/bash -c "cargo install ripgrep fd-find"
RUN /bin/bash -c "curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
RUN /bin/bash -c "chmod u+x nvim.appimage"
RUN /bin/bash -c "./nvim.appimage --appimage-extract"
RUN /bin/bash -c "./squashfs-root/AppRun --version"
RUN /bin/bash -c "mv squashfs-root /"
RUN /bin/bash -c "ln -s /squashfs-root/AppRun /usr/bin/nvim"
RUN /bin/bash -c "bash <(curl -s \"https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh\") -y"
