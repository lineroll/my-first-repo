FROM jenkins/jenkins:lts

USER root

# Встановлення необхідних пакетів
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Встановлення Docker CLI для Docker-in-Docker можливостей
RUN curl -fsSL https://get.docker.com | sh

# Повернення до користувача jenkins
USER jenkins

# Встановлення плагінів
RUN jenkins-plugin-cli --plugins \
    git \
    workflow-aggregator \
    docker-workflow \
    blueocean \
    configuration-as-code
