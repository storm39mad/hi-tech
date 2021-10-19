

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

helm install nfs-subdir-external-provisioner \
             nfs-subdir-external-provisioner/nfs-subdir-external-provisioner
            --set nfs.server=172.30.1.20
            --set nfs.path=/srv/nfs/k8s
```

Test pod

```bash
kubectl apply -f test-pvc.yaml
kubectl apply -f test-pod.yaml

kubectl get sc
kubectl get pvc
kubectl get pv
```

## MetalLB

(MetalLB docs)[https://metallb.universe.tf/]

### Router

```bash
apt install -y frr
vim /etc/frr/daemons
```
```
bgpd=yes
```
```bash
systemctl restart frr.service
```

```shell
vtysh
Router# conf t
Router(config)# router bgp 64501
Router(config-router)# neighbor 172.30.1.21 remote-as 64500
Router(config-router)# neighbor 172.30.1.22 remote-as 64500
Router(config-router)# neighbor 172.30.1.23 remote-as 64500
Router(config-router)# end
```

### Kubernetes

```bash
kubectl edit configmap -n kube-system kube-proxy
```
```
mode: "ipvs"
ipvs:
  strictARP: true
```

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
```

Configure BGP
```bash
kubectl apply -f ./metlalb.yaml
```

## Ingress

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```

## Prometheus

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install prometheus bitnami/kube-prometheus
```
```
prometheus-kube-prometheus-prometheus.default.svc.cluster.local
```

```bash
echo "User: admin"
echo "Password: $(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"
```

Password: Ihd5H4PwT4


```
http://prometheus-kube-prometheus-prometheus.default.svc.cluster.local:9090
```

## Nginx

```bash
apt install -y nginx
vim /etc/nginx/site-enabled/default
nginx -t
systemctl reload nginx.service
```

### Certbot

https://certbot.eff.org/lets-encrypt/debianstretch-nginx


```bash
sudo apt update
sudo apt install snapd

snap install core
snap refresh core

snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot

certbot --nginx

certbot -d 'result.c01.ht2021.ru'
```