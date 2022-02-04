FROM mrjeffapp/jenkins-pipeline

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

RUN wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.2%2B8/OpenJDK17U-jdk_x64_linux_hotspot_17.0.2_8.tar.gz \
    && tar xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.2_8.tar.gz && rm -rf OpenJDK17U-jdk_x64_linux_hotspot_17.0.2_8.tar.gz

ENV PATH "$PATH:/home/jenkins/jdk-17.0.2+8/bin"
