# Imagen base Fedora
FROM fedora:42

# Metadatos OCI de la imagen
LABEL org.opencontainers.image.title="cdtoolbox"
LABEL org.opencontainers.image.description="Toolbox personal para troubleshooting, OpenShift, Kubernetes y networking"
LABEL org.opencontainers.image.source="https://github.com/cosmind-rusu/cdtoolbox"

# Variable para mejorar la terminal
ENV TERM=xterm-256color

# Versión de oc/kubectl que queremos fijar
# Puedes cambiarla más adelante si quieres alinearla con tus clusters
ARG OC_VERSION=latest

# Instalación de herramientas útiles:
# - samba-client / cifs-utils: pruebas SMB/CIFS
# - curl / wget: llamadas HTTP y descargas
# - telnet / ncat: pruebas de red
# - openssh-clients: ssh, scp, sftp
# - bind-utils / iputils / net-tools: DNS, ping, ifconfig, netstat...
# - jq / yq: parseo de JSON y YAML
# - vim / nano / git: edición y control de versiones
RUN dnf install -y \
    samba-client \
    cifs-utils \
    curl \
    wget \
    telnet \
    openssh-clients \
    bind-utils \
    iputils \
    net-tools \
    procps-ng \
    jq \
    yq \
    vim \
    nano \
    git \
    tar \
    unzip \
    gzip \
    which \
    findutils \
    util-linux \
    nmap-ncat \
    && dnf clean all

# Descarga de oc y kubectl desde el mirror oficial de OpenShift
# Nota: el tarball de oc incluye también kubectl
RUN curl -L "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-linux.tar.gz" -o /tmp/oc.tar.gz \
    && tar -xzf /tmp/oc.tar.gz -C /usr/local/bin oc kubectl \
    && chmod +x /usr/local/bin/oc /usr/local/bin/kubectl \
    && rm -f /tmp/oc.tar.gz

# Aliases cómodos para la shell
RUN echo 'alias k=kubectl' >> /etc/bashrc \
    && echo 'alias kc=kubectl' >> /etc/bashrc \
    && echo 'alias ocp=oc' >> /etc/bashrc

# Comando por defecto al arrancar el contenedor
CMD ["/bin/bash"]