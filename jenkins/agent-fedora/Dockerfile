FROM fedora:latest

# Встановлення JRE (необхідно для агента Jenkins) та інструментів RPM
RUN dnf install -y \
    java-17-openjdk-headless \
    rpm-build \
    rpmdevtools \
    tar \
    git \
    curl \
    && dnf clean all

# Створення користувача jenkins
RUN useradd -m -d /home/jenkins jenkins

USER jenkins
WORKDIR /home/jenkins

# Завантаження agent.jar буде відбуватися при запуску через команду або ENTRYPOINT
# Для простоти використовуємо inbound-agent логіку
COPY --from=jenkins/inbound-agent:latest /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jenkins/inbound-agent:latest /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
