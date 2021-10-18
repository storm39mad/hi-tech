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

### NFS Server

Disable SELinux

```bash
[root@nfs ~]# setenforce 0
[root@nfs ~]# vim /etc/selinux/config 
```
```
SELINUX=permissive
```

Disable Firewalld

```bash
[root@nfs ~]# systemctl disable --now firewalld.service 
Removed /etc/systemd/system/multi-user.target.wants/firewalld.service.
Removed /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.
```

Install NFS

```bash
yum install -y nfs-utils
systemctl enable --now nfs-server
mkdir -p /srv/nfs/k8s
```

NFS Configuration

```bash
vim /etc/exports
```
```
/srv/nfs/k8s *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)
```
```bash
exportfs -rav
```

Install nfs utils on our k8s nodes

```bash
sudo clush -g all yum install -y nfs-utils
```
