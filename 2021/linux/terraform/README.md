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

### Variables
```bash
export TF_VAR_vsphere_password='Pa$$w0rd'
```

```
terraform init
terraform validate
terraform plan
terraform apply
terraform show
```
[ VMware vSphere Provider ](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs)


Clone and Customize [VMware Provider](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine#cloning-and-customization-example)

