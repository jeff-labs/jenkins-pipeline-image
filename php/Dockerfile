FROM mrjeffapp/jenkins-pipeline

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive

ARG php_version

RUN sudo add-apt-repository ppa:ondrej/php \
    && sudo apt-get install -y "php${php_version}-cli" "php${php_version}-gd" "php${php_version}-mbstring" "php${php_version}-zip" "php${php_version}-bcmath" "php${php_version}-xml" "php${php_version}-mysql" "php${php_version}-xdebug" \
    && sudo update-alternatives --set php "/usr/bin/php${php_version}" \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
