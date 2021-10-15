## Terraform


```bash
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update
sudo apt-get install terraform

terraform -install-autocomplete
```

```
terraform init
terraform validate
terraform plan
terraform apply
terraform show
```

https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs

