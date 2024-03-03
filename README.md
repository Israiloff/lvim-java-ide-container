![Docker Hub](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/israiloff/lvim)

# LunarVim Java IDE Docker Container Project Documentation

## Overview
This Dockerfile configures a container for [Java development using LunarVim](https://github.com/Israiloff/lvim-java-ide) 
on an Alpine Linux base. It's tailored for a Python 3 environment, enhanced with Java Development Kit (JDK) and other essential development tools.

## Dockerfile Description

### Base Image and JDK Configuration
- **Python Alpine Base**: Uses Python Alpine image; Python version defined by `PYTHON_VERSION`.
- **JDK Version Argument**: JDK version is set with `JDK_VERSION`.

### System Preparation
- Updates and upgrades the package manager, sets Bash as the default shell.

### Dependencies Installation
- Installs utilities (zip, unzip, curl, git), OpenJDK, Maven, Make, G++, npm, and others.
- Installs `neovim` for LunarVim and `fontconfig` for fonts.
- Installs `links` web browser.

### Rust Configuration
- Installs and configures Rust, adding tools like `ripgrep` and `fd-find`.

### LunarVim Setup
- Installs LunarVim; customizes configuration for Java IDE.
- Clones and sets up Java development tools (`eclipse.jdt.ls`, `java-debug`, `vscode-java-test`).
- Downloads Lombok and configures fonts.

### LunarVim and Zsh Update
- Updates LunarVim configuration.
- Installs Zsh, Oh My Zsh, configures theme, installs `zsh-vcs`.

### Container Entry Point
- Sets Zsh as the container's entry point.

## Build and Run
- Refer to `cmd.sh` for build and run instructions.

## Additional Information
- Ensure appropriate Python and JDK versions before building.
