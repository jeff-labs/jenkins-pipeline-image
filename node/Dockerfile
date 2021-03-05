ARG base
FROM mrjeffapp/jenkins-pipeline:$base

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

ARG node_version

RUN curl -sL "https://deb.nodesource.com/setup_$node_version.x" | sudo -E bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
  && sudo apt-get update && sudo apt-get install -y nodejs yarn \
  && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
