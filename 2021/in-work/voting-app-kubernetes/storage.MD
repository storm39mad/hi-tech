```bash
git clone --single-branch --branch release-1.7 https://github.com/rook/rook.git
```

```bash
cd rook/cluster/examples/kubernetes/ceph
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
kubectl create -f cluster.yaml
kubectl -n rook-ceph get pod
```

```bash
kubectl create -f toolbox.yaml

watch kubectl get -n rook-ceph cephcluster
kubectl -n rook-ceph exec -it rook-ceph-tools -- bash
ceph status
ceph osd status
```

```bash
cd csi/rbd
kubectl create -f storageclass.yaml
```

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

```bash
helm install prometheus bitnami/kube-prometheus
```

```bash
helm install grafana bitnami/grafana
echo "$(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"
```