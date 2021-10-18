## Install kubectl

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

```bash
kubectl apply -f ./pod.yaml
kubectl get pods
kubectl get pods -o wide
kubectl describe pod mynginx
kubectl logs mynginx
kubectl delete -f ./pod.yaml
```

[Использование affinity-правил Kubernetes для контроля назначения подов](https://habr.com/ru/company/otus/blog/576944/)