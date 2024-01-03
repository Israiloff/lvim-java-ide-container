BUILD_VERSION=0.0.1
docker build \
            --build-arg JDK_VERSION=21 \
            --build-arg PYTHON_VERSION=3 \
            -t israiloff/java-ide:BUILD_VERSION .
docker run -it -d --name java-ide israiloff/java-ide:BUILD_VERSION