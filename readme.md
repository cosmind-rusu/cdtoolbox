# cdtoolbox

Toolbox personal para troubleshooting y tareas DevOps.

Esta imagen está pensada para tener a mano herramientas comunes de diagnóstico y operación en entornos como:

- OpenShift
- Kubernetes
- Networking
- SMB / CIFS
- APIs HTTP
- DNS
- depuración general de contenedores

## Contenido

La imagen incluye, entre otras, estas herramientas:

- `oc`
- `kubectl`
- `smbclient`
- `cifs-utils`
- `curl`
- `wget`
- `telnet`
- `ncat`
- `ssh`
- `dig`
- `ping`
- `jq`
- `yq`
- `vim`
- `nano`
- `git`

## Imagen publicada

La imagen se publica automáticamente en GitHub Container Registry:

```bash
ghcr.io/cosmind-rusu/cdtoolbox:latest