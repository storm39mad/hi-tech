
# Лабораторная работа 2
## Общие требования

![image](https://user-images.githubusercontent.com/79700810/193747168-ac17aac2-d157-487a-bfc6-f4eced568ea7.png)

## Основные службы 
- NAT
- Firewall
- DNS
- DHCP
- Static IP Pools
- vApp
- vApp Network
- VM
- Customization 
- Terraform
- Docker

Виртуальная машина может существовать как автономная машина или она может существовать в vApp.

**vApp** — это составной объект, состоящий из одной или нескольких виртуальных машин, а также одной или нескольких сетей.

Вы можете создать автономную виртуальную машину или виртуальную машину в vApp. Автономная виртуальная машина напрямую подключена к виртуальному центру обработки данных организации.

Вы также можете создать виртуальную машину внутри vApp. Создав виртуальную машину внутри vApp, вы можете сгруппировать несколько виртуальных машин и связанные с ними сети. vApps позволяют создавать сложные приложения, и сохранить их в каталог для дальнейшего использования.

![image](https://user-images.githubusercontent.com/79700810/193747239-82f29af4-ec3c-447e-84d0-5a1fd8778daa.png)

# Organization VDC Networks

Сети виртуальных центров обработки данных (VDC) организации позволяют vApps взаимодействовать друг с другом или с внешними сетями за пределами организации.

В зависимости от подключения сети VDC организации к внешней сети различают несколько различных типов организации сетей VDC.
Сети VDC организации обеспечивают прямые или маршрутизируемые соединения с внешними сетями или могут быть изолированы от внешних сетей и других сетей VDC организации. 

![image](https://user-images.githubusercontent.com/79700810/193747260-bd9315ef-09b6-4eb5-8667-3287b19e2511.png)

## Isolated (Internal)

Изолированные сети доступны только той же организации VDC. Только виртуальные
машины в этой организации VDC могут подключаться и видеть трафик на внутренней
организации сети VDC.

Изолированные сети поддерживаются для виртуальных ЦОД организации, поддерживаемых центром обработки данных NSX-T.

И для организации VDC NSX Data Center for vSphere.
Сеть VDC изолированной организации предоставляет VDC организации изолированную,
частную сеть, к которой могут подключаться несколько виртуальных машин и приложений vApp. Эта сеть не обеспечивает подключения к виртуальным машинам за пределами организации VDC. Машины
за пределами организации VDC не имеют возможности подключения к компьютерам в организации
VDC.

## Routed

Маршрутизируемые сети доступны только той же организации VDC. Только виртуальные машины в этой организации VDC могут подключаться к этой сети.

Эта сеть также обеспечивает контролируемый доступ к внешней сети. Как системный администратор или администратор организации, вы можете настроить сетевой адрес трансляция (NAT), брандмауэр и настройки VPN, чтобы сделать определенные виртуальные машины доступными из внешней сети. Может быть IPv4 или IPv6

![image](https://user-images.githubusercontent.com/79700810/193747292-45aeef11-2a89-4b28-ac98-981f68def74b.png)

Чтобы зарезервировать один или несколько IP-адресов для назначения виртуальным машинам, требующим статические IP-адреса, настройте пулы статических IP-адресов для сети.

**Static IP Pool** — это пул, из которого автоматически выдаются IP-адреса. При настройке развернутых виртуальных машин адреса прописываются в ОС строго с помощью VMware Tools, а не DHCP

![image](https://user-images.githubusercontent.com/79700810/193747324-465ca20a-6076-4284-871d-51106f69271d.png)

Вы можете настроить определенные сети vApp для предоставления услуг DHCP виртуальным машинам в vApp.

![image](https://user-images.githubusercontent.com/79700810/193747341-2fae6b37-cb01-4e82-943a-4a6f51ba5114.png)

## Edge Gateway

Пограничный шлюз обеспечивает маршрутизируемую сеть VDC организации с возможностью подключения к внешним сетей и может предоставлять такие услуги, как балансировка нагрузки, преобразование сетевых адресов и брандмауэр. VMware Cloud Director поддерживает пограничные шлюзы IPv4 и IPv6.

![image](https://user-images.githubusercontent.com/79700810/193747354-7ddd1eab-66a4-468c-b7d2-95f18a58f7ad.png)
![image](https://user-images.githubusercontent.com/79700810/193747364-9ae8c772-cc15-4095-b966-f749b317d826.png)
![image](https://user-images.githubusercontent.com/79700810/193747378-c42aca8a-ac3e-4dc9-b9a8-50aa8c0a022f.png)
![image](https://user-images.githubusercontent.com/79700810/193747391-af404f17-4a2d-41ad-aa32-d4a139810d8b.png)

## Libraries

![image](https://user-images.githubusercontent.com/79700810/193747418-4da19bd3-e17d-4d30-8d76-1a983d8d14d6.png)
![image](https://user-images.githubusercontent.com/79700810/193747428-938e9771-50aa-4c6e-ae67-e5bd3d0caf0b.png)


## vApp Templates

![image](https://user-images.githubusercontent.com/79700810/193747449-915a92d5-f225-44a5-8e12-923faf756516.png)


# Создание vApp-01

vApp состоит из одной или нескольких виртуальных машин, которые обмениваются данными по сети и используют ресурсы и службы в развернутой среде. vApp может содержать несколько виртуальных машин. 


![image](https://user-images.githubusercontent.com/79700810/193747462-169c7dc7-b6ad-42fd-aece-07de46b7e196.png)
![image](https://user-images.githubusercontent.com/79700810/193747475-355abb3d-b7dd-4081-9ea1-3c410451ee67.png)

Вы можете назначить IPv4 адреса к виртуальным машинам, подключенным к сетям IPv4

![image](https://user-images.githubusercontent.com/79700810/193747492-1e5ad98a-5dc2-4588-bfe9-ac9fd3818945.png)
![image](https://user-images.githubusercontent.com/79700810/193747505-84a1d47d-797b-4086-966e-7accab971969.png)

Создадим виртуальную машину внутри vApp-01

![image](https://user-images.githubusercontent.com/79700810/193747514-407233a6-48fa-4300-b40c-067558f0de64.png)

Указываем имя, операционную систему, и образ

![image](https://user-images.githubusercontent.com/79700810/193747524-ed9bd7bc-3346-4434-aa43-83ef8ad486bd.png)

Указываем необходимые ресурсы

![image](https://user-images.githubusercontent.com/79700810/193747536-7b8e397d-1946-4bb1-83c6-73187fc9604a.png)

Указываем необходимое место на диске

![image](https://user-images.githubusercontent.com/79700810/193747541-b309e77b-8903-482a-ad59-17c13aa8d3b4.png)

Указываем сетевые настройки

![image](https://user-images.githubusercontent.com/79700810/193747550-57a037d6-755c-4945-accc-f321f35788f6.png)

По аналогии создаем ещё одну виртуальную машину

![image](https://user-images.githubusercontent.com/79700810/193747557-6d3ecd6f-db86-415f-813c-b190011b76dc.png)

## Управление виртуальной машиной

После создания ВМ вы можете проверить их параметры и подключиться к консоли

![image](https://user-images.githubusercontent.com/79700810/193747586-00e6465c-ba50-47b5-b1cb-db33a1798068.png)
![image](https://user-images.githubusercontent.com/79700810/193747595-b5059a0c-7c59-4851-a424-2b9c2609e0c0.png)

Для открытия консоли ВМ необходитмо нажать на `Launch web console`

![image](https://user-images.githubusercontent.com/79700810/193747609-8dcb7395-778d-462c-83c3-85c82356061f.png)
![image](https://user-images.githubusercontent.com/79700810/193747620-896cbed6-f514-475a-b9a9-568a6961ada1.png)

## Установка из образа

Создаем ещё один vApp

![image](https://user-images.githubusercontent.com/79700810/193747633-ff9f4a55-d99c-47da-9fac-d2febb2fa3e1.png)

Добавляем сеть

![image](https://user-images.githubusercontent.com/79700810/193747639-20f6f007-fe5f-4d6f-8e69-2070f491ddff.png)
![image](https://user-images.githubusercontent.com/79700810/193747649-97aa6942-f5d7-403f-a5c8-6aebce77b27c.png)

Добавляем Static IP Pool

![image](https://user-images.githubusercontent.com/79700810/193747658-ee1a329a-9ed4-40cc-8eea-9a1bb43968aa.png)

Создаем ВМ внутри vApp

![image](https://user-images.githubusercontent.com/79700810/193747666-68479f43-c0f6-4c92-b004-3e58c9df3879.png)
![image](https://user-images.githubusercontent.com/79700810/193747672-93c3e7fb-17c1-4a19-839b-5b2e09995c9a.png)

Выбираем тип установки из образа и выбираем нужный образ

![image](https://user-images.githubusercontent.com/79700810/193747680-720cd41e-27b7-44e4-990b-35a9d274ece8.png)

Указываем необходимые параметры вм

![image](https://user-images.githubusercontent.com/79700810/193747687-62eeafbb-65eb-46ab-9872-bf45de732ba6.png)

Отмечаем чекбокс на подключении сети, выбираем нужную сеть и выбираем Static IP Pool

![image](https://user-images.githubusercontent.com/79700810/193747693-462059c5-92e5-439c-83e7-c529f0cec52a.png)

Повторяем по аналогии и создаем еще 1 ВМ

![image](https://user-images.githubusercontent.com/79700810/193747700-a0dc50f3-590e-4ef5-a68e-cb55947bde9a.png)

Проверяем консоли ВМ

![image](https://user-images.githubusercontent.com/79700810/193747707-c4fe6495-70fd-4e5e-9ecc-e17e2f3fe10b.png)


## Guest OS Customization

Для дальнейшей кастомизации необходимо выключить ВМ

![image](https://user-images.githubusercontent.com/79700810/193747735-a9b0b14b-16a8-4734-9c34-419fcafddd96.png)

Перейти в редактирование ВМ в раздел Guest OS - Customization - Edit

![image](https://user-images.githubusercontent.com/79700810/193747741-a7e3a2df-0741-4857-8585-fe24085c0fc5.png)

Отметить чекбокс `Allow local administrator password`

![image](https://user-images.githubusercontent.com/79700810/193747750-9d90d943-4dec-4129-9533-f1d633ce157d.png)

Для применения кастомизации, необходимо в параметрах включения выбрать `Power On, Force Recustomization`

![image](https://user-images.githubusercontent.com/79700810/193747781-e2adc98d-6be3-46fc-926c-3a7bda724e8c.png)

После включения ВМ необходимо снова перейти в раздел кастомизации, там появится новый сгенерированный пароль для ВМ

![image](https://user-images.githubusercontent.com/79700810/193747790-40e63288-073e-4f6b-908f-b2638b3f3c50.png)


# Terraform

Для загрузки провайдера необхоимо создать файл main.tf 


```
{
  # Ref: https://registry.terraform.io/providers/vmware/vcd/latest/docs  
  required_providers {
    vcd = {
      source = "VMware/vcd"
      version  = ">= 3.4.0"
    }
  }
}

# Ref: https://registry.terraform.io/providers/vmware/vcd/latest/docs
provider "vcd" {
  user                  = "sccmadmkp11"
  password              = "Pa$$w0rd"
  org                   = "rukavishnikov"
  vdc                   = "vdcrukavishnikov"
  url                   = "https://vcd.kp11.ru/api"
  allow_unverified_ssl  = true
  max_retry_timeout     = 240
}
```

![image](https://user-images.githubusercontent.com/79700810/193747840-0eda74a1-e26f-4188-a0f0-95f1d626f93d.png)

## Terraform init

После создания файла и указания в нем необходимых параметров, следует выполнить команду terraform init

![image](https://user-images.githubusercontent.com/79700810/193747809-16a14a03-e68a-4392-80f9-cee1f6e9dbc5.png)

# Создание vApp1
## Создание vApp с vApp Network, к которому подключена ВМ и получает IP адрес через Static IP Pools

Для создания vApp1 необходимо создать файл vApp1.tf и указать следующие параметры

```
resource "vcd_vapp" "web" {
  name = "web"

}

resource "vcd_vapp_network" "vappNet" {
  name               = "NetvAPP"
  vapp_name          = vcd_vapp.web.name
  gateway            = "192.168.2.1"
  netmask            = "255.255.255.0"

  static_ip_pool {
    start_address = "192.168.2.51"
    end_address   = "192.168.2.100"
  }

}
```

![image](https://user-images.githubusercontent.com/79700810/193747868-ea1f3282-7da9-4d36-bb53-3bad2712a713.png)

## Создание ВМ

```
resource "vcd_vapp_vm" "TestVm" {

  vapp_name = vcd_vapp.web.name

  name = "TestVm"
  catalog_name  = "TM_VM"
  template_name = "vCD_CentOS_Stream_8"
  cpus          = 2
  memory        = 2048

  network {
    name               = vcd_vapp_network.vappNet.name
    type               = "vapp"
    ip_allocation_mode = "POOL"
    is_primary         = true
  }
}
```

![image](https://user-images.githubusercontent.com/79700810/193747892-3ffbef72-7042-4dcd-8d56-5a215033fdef.png)

# Создание vAPP2
## Создание vApp и подключение существующей сети OrgVDC к которой подключена ВМ и получает IP адрес через Static IP Pools

```
data "vcd_network_routed" "net" {
  name = "local"
}

resource "vcd_vapp" "web2" {
  name = "web2"
}

resource "vcd_vapp_org_network" "routed-net" {
  vapp_name        = vcd_vapp.web2.name
  org_network_name = data.vcd_network_routed.net.name
}
```

![image](https://user-images.githubusercontent.com/79700810/193747920-5922714a-2b51-4009-8fdb-918d0b51118a.png)

## Создание ВМ
```
resource "vcd_vapp_vm" "TestVm2" {

  vapp_name = vcd_vapp.web2.name

  name = "TestVm2"
  catalog_name  = "TM_VM"
  template_name = "vCD_CentOS_Stream_8"
  cpus          = 2
  memory        = 2048

  network {
    name               = vcd_vapp_org_network.routed-net.org_network_name
    type               = "org"
    ip_allocation_mode = "POOL"
    is_primary         = true
  }
}
```
![image](https://user-images.githubusercontent.com/79700810/193747938-1e9410b7-6c59-422d-8914-74c391d30763.png)

# Terraform plan

После создания файлов, необходимо проверить на корректность, используя команду `terraform plan`

![image](https://user-images.githubusercontent.com/79700810/193747961-df3717cf-12c4-4b75-bf3f-b1d523f066bb.png)


# Terraform apply

Применение манифеста

![image](https://user-images.githubusercontent.com/79700810/193747988-b2a53e9a-5b78-4895-9152-0b563070dad3.png)

Необходимо ответить **YES**

![image](https://user-images.githubusercontent.com/79700810/193748006-367fef57-8523-4460-b812-3f6d98c9451e.png)

После успешного применения вам отобразится сообщение **Apply complete!**
![image](https://user-images.githubusercontent.com/79700810/193748024-1ca5f4fe-bad8-49a6-b909-a5270e3e4e3e.png)

В разделе vApp вы обнаружите созданную инфраструктуру с помощью Terraform 

![image](https://user-images.githubusercontent.com/79700810/193748041-8b46c266-a404-48e3-9cca-4eba7c7c116e.png)


# Docker

Создадим дополнительную ВМ в vApp-01 из образа

![image](https://user-images.githubusercontent.com/79700810/193748160-9d0b6cdb-bea8-4ccf-a1d4-6cdbe8e2276a.png)

Далее необходимо установить необходимые пакеты
```
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce
```
```
docker pull nginx
docker images
docker run --name app1 -p 8080:80 -d nginx
docker run --name app2 -p 8081:80 -d nginx
```
```
curl http://192.168.78.10:8080
curl http://192.168.78.10:8081
```
```
docker ps
docker stop app1
docker stop app2
docker rm app1
docker rm app2
```
```
docker ps
```

Далее создаем ещё один vApp с сетью OrgVDC внутри которого создаем ВМ с ОС Windows

![image](https://user-images.githubusercontent.com/79700810/193748184-3ac58acf-d8dc-4b21-a9e0-131bbcdd1b04.png)

Проверяем работу контейнеров Docker

![image](https://user-images.githubusercontent.com/79700810/193748195-4ae0fc00-d1e5-4cd7-91c4-6048f10b3ace.png)



