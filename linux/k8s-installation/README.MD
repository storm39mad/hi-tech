### Cluster shell installation

```bash
apt install clustershell
vim /etc/clustershell/groups.d/local.cfg 
```
Ours hosts:
```
all: 172.30.1.2[1-3]
```

```bash
clush -g all nmcli connection modify ens192 ipv4.dns 172.30.0.1
clush -g all nmcli connection show ens192 | grep ipv4.dns

clush -g all nmcli connection modify ens192 ethtool.feature-tx off
clush -g all nmcli connection show ens192 | grep ethtool

clush -g all nmcli connection up ens192

clush -g all systemctl disable --now firewalld.service
```

### Kubespray

Get to home directory
```bash
cd ~
sudo -i
```

Copy our public key to hosts

```bash
ssh-keygen
ssh-copy-id root@172.30.1.21
ssh-copy-id root@172.30.1.22
ssh-copy-id root@172.30.1.23
```

```bash
git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray
```

Kubespray configuration

```bash
# Install dependencies from ``requirements.txt``
sudo pip3 install -r requirements.txt

# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
```