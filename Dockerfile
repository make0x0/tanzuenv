FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
        vim screen sudo bash-completion \
        wget curl git \
        make build-essential \
        language-pack-ja-base language-pack-ja \
        jq glances iotop ibus-mozc \
        libffi-dev && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/*
        
ENV LANG=ja_JP.UTF-8

WORKDIR /root

# install tce cli
#ALLOW_INSTALL_AS_ROOT

ENV ALLOW_INSTALL_AS_ROOT="true"
RUN ARCHIVE_NAME="tce-linux-amd64" && curl -L https://github.com/vmware-tanzu/community-edition/releases/download/v0.9.1/tce-linux-amd64-v0.9.1.tar.gz -o ${ARCHIVE_NAME}.tar.gz && \
    mkdir ${ARCHIVE_NAME} && tar xvzf ${ARCHIVE_NAME}.tar.gz -C ${ARCHIVE_NAME} --strip-components 1 && \
    cd ${ARCHIVE_NAME} && \
    ALLOW_INSTALL_AS_ROOT="true" && ./install.sh && \
    which tanzu

# install kubectl
RUN curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN echo "source <(helm completion bash)" >> ~/.bashrc

# install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN DOCKER_VERSION="5:20.10.11~3-0~ubuntu-focal"; apt-get install -y docker-ce-cli=${DOCKER_VERSION}
