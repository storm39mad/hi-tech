
```bash
clush -g all nmcli connection modify ens192 ipv4.dns 172.30.0.1
clush -g all nmcli connection show ens192 | grep ipv4.dns

clush -g all nmcli connection modify ens192 ethtool.feature-tx off
clush -g all nmcli connection show ens192 | grep ethtool

clush -g all nmcli connection up ens192
```