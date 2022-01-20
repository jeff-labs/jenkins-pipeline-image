FROM ubuntu:18.04

MAINTAINER Jeff

ARG sonar_scanner_version

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt-get update \
  && apt-get install --no-install-recommends -y locales libfontconfig sudo git build-essential curl wget gpg-agent \
   gnupg ca-certificates software-properties-common awscli zip unzip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Docker CE
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
  && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" \
  && apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Sonar Scanner
RUN wget "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$sonar_scanner_version-linux.zip" \
  && unzip "sonar-scanner-cli-$sonar_scanner_version-linux.zip" \
  && mv "sonar-scanner-$sonar_scanner_version-linux" /opt/sonar-scanner \
  && rm -rf "sonar-scanner-cli-$sonar_scanner_version-linux.zip"

ENV SONAR_SCANNER_OPTS "-Xmx2048m"
ENV PATH "$PATH:/opt/sonar-scanner/bin"

# Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && DESIRED_VERSION=v3.7.0 ./get_helm.sh \
    && rm -rf get_helm.sh

# Jenkins user
RUN groupadd --gid 1001 jenkins \
  && useradd --uid 1001 --gid jenkins -G docker --shell /bin/bash --create-home jenkins \
  && echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-jenkins \
  && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

USER jenkins
WORKDIR /home/jenkins

# Default git configuration
RUN git config --global user.email "jenkins@localhost" && git config --global user.name "Jenkins"
