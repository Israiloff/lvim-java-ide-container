declare BUILD_VERSION=0.0.4
docker build --build-arg JDK_VERSION=21 --build-arg PYTHON_VERSION=3 -t israiloff/lvim:$BUILD_VERSION . &&
docker run -it -d --name lvim israiloff/lvim:$BUILD_VERSION
