ARG ANDROID_VERSION=30

FROM androidsdk/android-${ANDROID_VERSION}

SHELL ["/bin/bash", "-c"]
RUN apt-get update \
    && apt-get install -y curl unzip zip \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install sdkman
RUN curl --silent "https://get.sdkman.io" | bash

# install node and npm
ARG NODE_VERSION=12.22.1
RUN source $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install java
ARG JAVA_VERSION=11.0.12-open
ARG GRADLE_VERSION=7.1.1
RUN source "/root/.sdkman/bin/sdkman-init.sh" \
    && sdk install java ${JAVA_VERSION} \
    && sdk use java ${JAVA_VERSION} \
    && sdk install gradle ${GRADLE_VERSION} \
    && sdk use gradle ${GRADLE_VERSION}

# install cordova
ARG CORDOVA_VERSION=11.0.0
RUN npm install -g cordova@${CORDOVA_VERSION}

# set environmental variables for java and gradle
ENV GRADLE_HOME /root/.sdkman/candidates/gradle/current
ENV JAVA_HOME /root/.sdkman/candidates/java/current
ENV PATH $GRADLE_HOME/bin:$PATH

# install extra build-tools version
ARG EXTRA_BUILD_TOOLS_VERSION
RUN if [ ! -z "${EXTRA_BUILD_TOOLS_VERSION}" ]; then sdkmanager "build-tools;${EXTRA_BUILD_TOOLS_VERSION}"; fi;


# install extra build-tools version
ARG EXTRA_PLATFORMS_VERSION
RUN if [ ! -z "${EXTRA_PLATFORMS_VERSION}" ]; then sdkmanager "platforms;${EXTRA_PLATFORMS_VERSION}"; fi;

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
