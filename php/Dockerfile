FROM mrjeffapp/jenkins-pipeline-base

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

ARG php_version

RUN sudo add-apt-repository ppa:ondrej/php \
    && sudo apt-get install -y "php${php_version}-cli" "php${php_version}-gd" "php${php_version}-mbstring" composer \
    && sudo update-alternatives --set php "/usr/bin/php${php_version}" \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
