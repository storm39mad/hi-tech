

## Helm 

(HELM install)[https://helm.sh/docs/intro/install/]

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod +x get_helm.sh 
./get_helm.sh
```

Autocompletion

```bash
sudo -i
helm completion bash > /etc/bash_completion.d/helm
exit
source /etc/bash_completion.d/helm
```

## StorageClass

```bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

```