## Ansible 

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

```bash
ssh-keygen
ssh-copy-id root@172.30.1.31
ssh-copy-id root@172.30.1.32
```

```bash
ansible-playbook --user root -i host.ini playbook.yml 
```

```bash
ansible-galaxy init docker
```