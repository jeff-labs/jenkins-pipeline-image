FROM mrjeffapp/jenkins-pipeline-base

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

ARG java_version

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add - \
  && sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
  && sudo apt-get install -y adoptopenjdk-${java_version}-hotspot
