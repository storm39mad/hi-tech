### Kubernetes

```bash
sudo -i
git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray
```

```bash
ssh-keygen
ssh-copy-id root@172.30.1.11
ssh-copy-id root@172.30.1.12
ssh-copy-id root@172.30.1.13

ssh 172.30.1.11 systemctl disable --now firewalld.service
ssh 172.30.1.12 systemctl disable --now firewalld.service
ssh 172.30.1.13 systemctl disable --now firewalld.service

```

```bash
apt install python3-venv python3-pip
python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
```

```
less README.MD
```

```bash
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(172.30.1.11 172.30.1.12 172.30.1.13)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

```bash
vim inventory/mycluster/hosts.yaml
```

```YAML
all:
  hosts:
    k8s1:
      ansible_host: 172.30.1.11
      ip: 172.30.1.11
      access_ip: 172.30.1.11
    k8s2:
      ansible_host: 172.30.1.12
      ip: 172.30.1.12
      access_ip: 172.30.1.12
    k8s3:
      ansible_host: 172.30.1.13
      ip: 172.30.1.13
      access_ip: 172.30.1.13
  children:
    kube_control_plane:
      hosts:
        k8s1:
        k8s2:
    kube_node:
      hosts:
        k8s1:
        k8s2:
        k8s3:
    etcd:
      hosts:
        k8s1:
        k8s2:
        k8s3:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

```
kubespray/inventory/mycluster/group_vars/all/all.yml
http_proxy: ''
https_proxy: ''
no_proxy=localhost,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16
```

```bash
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml

deactivate
cd ~
scp -r root@172.30.1.11:/root/.kube /home/user/
sed -i 's/127.0.0.1/172.30.1.11/' /home/user/.kube/config
chown -R user:user /home/user/.kube
exit

```

## Kubectl

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubectl
```

### Bash completion

```bash
sudo -i
kubectl completion bash > /etc/bash_completion.d/kubectl
exit
source /etc/bash_completion.d/kubectl
```

## Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
### Bash completion

```bash
sudo -i
helm completion bash > /etc/bash_completion.d/helm
exit
source /etc/bash_completion.d/helm
```

## NFS  server

```bash
hostnamectl set-hostname nfs

nmcli connection modify ens192 \
    connection.autoconnect yes \
    ifname ens192 \
    ipv4.method manual \
    ipv4.address 172.30.1.21/24 \
    ipv4.gateway 172.30.1.254 \
    ipv4.dns 172.30.0.1

nmcli connection up ens192
```

```bash
dnf install nfs-utils
systemctl enable --now nfs-server
mkdir /srv/nfs
```

```bash
vim /etc/exports
``` 

```
/srv/nfs 172.30.1.0/24(rw,sync,no_root_squash,no_subtree_check)
```

```bash
exportfs -ra
exportfs -v
```

```bash
firewall-cmd --new-zone=nfs --permanent
firewall-cmd --zone=nfs --add-service=nfs --permanent
firewall-cmd --zone=nfs --add-source=172.30.1.0/24 --permanent
firewall-cmd --reload
```

```bash
ssh root@172.30.1.11 dnf install -y nfs-utils
ssh root@172.30.1.12 dnf install -y nfs-utils
ssh root@172.30.1.12 dnf install -y nfs-utils
```
