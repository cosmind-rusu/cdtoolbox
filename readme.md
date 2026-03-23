# cdtoolbox

Toolbox personal para troubleshooting y tareas DevOps.

Incluye herramientas útiles para trabajar y depurar en entornos como:

- OpenShift
- Kubernetes
- networking
- SMB / CIFS
- APIs HTTP
- DNS
- contenedores y debugging general

## Herramientas incluidas

- `oc`
- `kubectl`
- `smbclient`
- `cifs-utils`
- `curl`
- `wget`
- `telnet`
- `nc`
- `ssh`
- `dig`
- `ping`
- `jq`
- `yq`
- `vim`
- `nano`
- `git`

## Sobre `oc`

`oc` es el cliente oficial de OpenShift.

Sirve para autenticarse, cambiar de proyecto, consultar recursos, listar pods, revisar nodos, hacer debug y operar clusters OpenShift/Kubernetes desde línea de comandos.

Ejemplos:

```bash
oc version --client
oc login https://api.cluster.example:6443
oc project test
oc get pods -A
oc debug node/<nombre-del-nodo>