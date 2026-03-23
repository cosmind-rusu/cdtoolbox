# Imagen base
FROM fedora:42

# Metadatos OCI
LABEL org.opencontainers.image.title="cdtoolbox"
LABEL org.opencontainers.image.description="Toolbox personal para troubleshooting, OpenShift, Kubernetes, networking y SMB"
LABEL org.opencontainers.image.source="https://github.com/cosmind-rusu/cdtoolbox"

# Terminal más cómoda
ENV TERM=xterm-256color

# Versión fija del cliente de OpenShift
# Puedes cambiarla más adelante para alinearla con tus clusters
ARG OC_VERSION=4.18.0

# Instalación de herramientas base
# - samba-client / cifs-utils: pruebas SMB/CIFS
# - curl / wget: peticiones HTTP y descargas
# - telnet / ncat: pruebas de conectividad
# - openssh-clients: ssh, scp, sftp
# - bind-utils / iputils / net-tools: DNS, ping, red
# - jq / yq: parseo JSON/YAML
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
    hostname \
    && dnf clean all

# Descarga del cliente oficial de OpenShift (oc), que también incluye kubectl
# "oc" es el cliente CLI de OpenShift para autenticarse, consultar recursos,
# depurar proyectos, pods, nodos y operar clusters OpenShift/Kubernetes.
RUN curl -L "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-linux.tar.gz" -o /tmp/oc.tar.gz \
    && tar -xzf /tmp/oc.tar.gz -C /usr/local/bin oc kubectl \
    && chmod +x /usr/local/bin/oc /usr/local/bin/kubectl \
    && rm -f /tmp/oc.tar.gz

# Banner de bienvenida con colores ANSI
RUN cat > /etc/motd <<'EOF'
\033[1;36m============================================================\033[0m
\033[1;32m                  Bienvenido a cdtoolbox 🚀\033[0m
\033[1;36m============================================================\033[0m

\033[1;33mAutor:\033[0m Cosmin Rusu
\033[1;33mGitHub:\033[0m https://github.com/cosmind-rusu/cdtoolbox

\033[1;35mDescripción:\033[0m
  Toolbox personal para troubleshooting, OpenShift, Kubernetes,
  SMB/CIFS, networking y depuración general.

\033[1;34mHerramientas incluidas:\033[0m
  - oc / kubectl
  - smbclient / cifs-utils
  - curl / wget
  - nc / telnet
  - dig / ping / ssh
  - jq / yq / git / vim

\033[1;34mSobre "oc":\033[0m
  "oc" es el cliente oficial de OpenShift.
  Sirve para autenticarse, cambiar de proyecto, consultar recursos,
  depurar pods/nodos y operar clusters OpenShift/Kubernetes.

\033[1;32mComandos rápidos:\033[0m
  oc version --client
  kubectl version --client
  nc -vz <ip> 445
  smbclient -L //<ip> -U usuario
  curl -I https://example.com
  oc project
  oc get pods -A

\033[1;32mAliases útiles:\033[0m
  k='kubectl'
  kc='kubectl'
  ocp='oc'
  cdt-help
EOF

# Script que imprime el banner interpretando colores
RUN cat > /usr/local/bin/cdt-banner <<'EOF' \
&& chmod +x /usr/local/bin/cdt-banner
#!/usr/bin/env bash
echo -e "$(cat /etc/motd)"
EOF

# Script de ayuda rápida
RUN cat > /usr/local/bin/cdt-help <<'EOF' \
&& chmod +x /usr/local/bin/cdt-help
#!/usr/bin/env bash
echo
echo "=== cdtoolbox help ==="
echo
echo "OpenShift / Kubernetes:"
echo "  oc version --client"
echo "  oc login <api>"
echo "  oc project <namespace>"
echo "  oc get pods -A"
echo "  k get nodes"
echo
echo "SMB / CIFS:"
echo "  smbclient -L //<ip> -U usuario"
echo "  nc -vz <ip> 445"
echo
echo "Red / HTTP:"
echo "  dig <host>"
echo "  ping -c 3 <ip>"
echo "  curl -I https://example.com"
echo
echo "Info:"
echo "  cdt-banner    # muestra el banner"
echo "  cdt-help      # muestra esta ayuda"
echo
EOF

# Aliases y carga automática del banner al iniciar bash interactiva
RUN cat >> /etc/bashrc <<'EOF'

alias k=kubectl
alias kc=kubectl
alias ocp=oc

if [[ $- == *i* ]]; then
  /usr/local/bin/cdt-banner
fi
EOF

# Shell por defecto
CMD ["/bin/bash"]