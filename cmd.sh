BUILD_VERSION=0.0.5
docker build \
            --build-arg JDK_VERSION=21 \
            --build-arg PYTHON_VERSION=3 \
            --build-arg TIMEZONE=Asia/Tashkent \
            -t israiloff/lvim:$BUILD_VERSION .
docker run -it -d --name lvim israiloff/lvim:$BUILD_VERSION
