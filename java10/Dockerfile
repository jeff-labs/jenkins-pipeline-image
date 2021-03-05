FROM mrjeffapp/jenkins-pipeline

MAINTAINER Jeff

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME="/home/jenkins/.sdkman/candidates/java/current"
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN curl -s "https://get.sdkman.io" | bash

RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java 10.0.2-open && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"
