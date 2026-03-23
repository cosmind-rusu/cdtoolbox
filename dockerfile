FROM fedora:40

# Evitar prompts
ENV TERM=xterm

# Instalar herramientas útiles
RUN dnf install -y \
    samba-client \
    cifs-utils \
    curl \
    wget \
    telnet \
    iputils \
    bind-utils \
    net-tools \
    procps-ng \
    jq \
    vim \
    git \
    tar \
    gzip \
    unzip \
    && dnf clean all

# Instalar oc CLI (OpenShift)
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz \
    | tar -xz -C /usr/local/bin oc kubectl

# Default shell
CMD ["/bin/bash"]