
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