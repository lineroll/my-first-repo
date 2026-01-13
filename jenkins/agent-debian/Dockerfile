FROM jenkins/inbound-agent:latest

USER root

# Встановлення інструментів для збірки DEB-пакетів
RUN apt-get update && apt-get install -y \
    build-essential \
    debhelper \
    devscripts \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
