FROM ubuntu:18.04

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt-get update \
  && apt-get install --no-install-recommends -y sudo git build-essential curl wget gpg-agent gnupg ca-certificates software-properties-common awscli zip unzip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Docker CE
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
  && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" \
  && apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Jenkins user
RUN groupadd --gid 1001 jenkins \
  && useradd --uid 1001 --gid jenkins -G docker --shell /bin/bash --create-home jenkins \
  && echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-jenkins \
  && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

USER jenkins
WORKDIR /home/jenkins

# Default git configuration
RUN git config --global user.email "jenkins@localhost" && git config --global user.name "Jenkins"
