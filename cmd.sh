BUILD_VERSION=0.0.10
docker build \
            --build-arg JDK_VERSION=21 \
            --build-arg PYTHON_VERSION=3 \
            --build-arg TIMEZONE=Asia/Tashkent \
            -t israiloff/lvim:$BUILD_VERSION .
docker tag israiloff/lvim:$BUILD_VERSION israiloff/lvim:latest
