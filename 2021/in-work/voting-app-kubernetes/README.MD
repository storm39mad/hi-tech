
## Приложение

Устанавливаем git и клонируем репозиторий с приложением

```bash
git clone https://github.com/dockersamples/example-voting-app
```

Создаем директорию в которой будем работать

```bash
mkdir vote-app-k8s
cp -rv example-voting-app/vote vote-app-k8s/vote
cp -rv example-voting-app/worker vote-app-k8s/worker
cp -rv example-voting-app/result vote-app-k8s/result
cd vote-app-k8s
```

```bash
docker login

docker build vote/ -t 5d20240/ht-vote:latest
docker build worker/ -t 5d20240/ht-worker:latest
docker build result/ -t 5d20240/ht-result:latest

docker push 5d20240/ht-vote:latest
docker push 5d20240/ht-worker:latest
docker push 5d20240/ht-result:latest
```

## MetalLB

https://metallb.universe.tf/


```bash
kubectl edit configmap -n kube-system kube-proxy

```


```YAML
apiVersion: kubepio/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
  ```

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
```
Router

```bash
Router# conf t
Router(config)# router bgp 64501
Router(config-router)# neighbor 172.30.1.11 remote-as 64500
Router(config-router)# neighbor 172.30.1.12 remote-as 64500
Router(config-router)# neighbor 172.30.1.13 remote-as 64500
Router(config-router)# end
```

##  NGINX INGRESS


```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```

```bash
kubectl edit svc ingress-nginx-controller 
```

## Cert Manager

```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml
kubectl get pods --namespace cert-manager
```


```YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: cert-manager
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@ht2021.ru
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
```

```bash
kubectl get certificate
```