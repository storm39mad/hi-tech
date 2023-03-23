1. Работа с подами через kubectl
```bash
    kubectl run myapp --image=nginx:1.21.3
    kubectl get pods
    kubectl describe pod myapp
    kubectl delete pod myapp
```

2. Создание файла конфигурации пода через kubectl

```bash
    kubectl run myapp --image=nginx:1.21.3 --dry-run=client -o yaml > pod.yaml
    kubectl apply -f ./pod.yaml
    kubectl get pods
    kubectl delete pod myapp
```

3. Создание Deployment

```bash
    kubectl create deployment appDeployment --image=nginx:1.21.3 
    kubectl get deployments
    kubectl describe deployment appDeployment
    kubectl get pods
    kubectl delete deployment appDeployment
```

4. Создание файла конфигурации деплоймента через kubectl

```bash
    kubectl create deployment appDeployment --image=nginx:1.21.3 --dry-run=client -o yaml
    kubectl get deployments
    kubectl get pods
```

5. Создание сервиса

```bash
    kubectl expose deployment appDeployment --name appService --port=80 --type=NodePort
    kubectl get svc
    kubectl describe svc appService
```
