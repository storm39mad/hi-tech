## Лабораторная работа 5

![DEMO2022azure-Страница 7 (7)](https://user-images.githubusercontent.com/79700810/198591868-87afe496-41c3-4070-ab17-b349fd1e3108.jpg)



## Задание

1) создание шоблона виртуальной машины Astra на гипервизоре
2) создание необходимых сигментов сетей и настройки пропускания трафика на гипервизоре
3) Развертывание доменной инфраструктуры с использование отечественного производителя

Доллжна в себя включать:
1) Централизованная аутентификация
2) Централизованное управление
3) Журналирование
4) Мониторинг 
5) Групповые политики
6) Резервирование и отказоустойчивость
7) Удаленный доступ
8) Безопасность
9) Маршрутизация
10) Распределенное хранение данных
11) Развертывание баз данных
12) Веб-сервер
13) Балансировка нагрузки
14) Управление контейнерами приложений
15) CI/CD для приложений


### Создание виртуальноый машины 

![image](https://user-images.githubusercontent.com/79700810/198566202-7daa2b4d-6db1-471b-a5ee-aa7f0f9deb14.png)

![image](https://user-images.githubusercontent.com/79700810/198566462-fac892a6-608d-4c5b-822d-a2b951171d6e.png)

![image](https://user-images.githubusercontent.com/79700810/198566551-3103acea-327a-4ff2-a879-36d6e3706f06.png)

![image](https://user-images.githubusercontent.com/79700810/198566690-f0c25168-1155-414b-ac9c-d50c4e1ffbb1.png)


![image](https://user-images.githubusercontent.com/79700810/198566706-2d0d3b0e-3ca7-43d7-924a-8ed261ec8fdf.png)


![image](https://user-images.githubusercontent.com/79700810/198566821-91b356f1-29c7-4541-acf7-fdb5d12c3cea.png)


![image](https://user-images.githubusercontent.com/79700810/198566951-6a26b9b1-bbc1-4569-8923-9c38720e09a9.png)


или использовать VM Network
![image](https://user-images.githubusercontent.com/79700810/198567056-7a8a67d0-6640-4e51-8cb4-2c9d5a6bb0bb.png)


### Установка


Установка дистрибутива с помощью графического интерфейса

![image](https://user-images.githubusercontent.com/79700810/198209430-93f31ecd-43b8-4150-9e90-51a60ad8ad96.png)

![image](https://user-images.githubusercontent.com/79700810/198209583-eecca7ac-87d0-4401-8252-bd9a328dda2e.png)

![image](https://user-images.githubusercontent.com/79700810/198209601-059622ae-2424-496f-b269-7fb52a11f5ca.png)

![image](https://user-images.githubusercontent.com/79700810/198209614-7eab206c-1315-4546-9d6e-6ec1e2908735.png)

![image](https://user-images.githubusercontent.com/79700810/198209625-78651d65-3915-43c9-8378-12120a551976.png)

![image](https://user-images.githubusercontent.com/79700810/198209633-bc5c2f09-0174-4637-a162-8e8ac354a312.png)

![image](https://user-images.githubusercontent.com/79700810/198209645-2755f671-953a-44a1-a2b3-ddce5e219bce.png)

![image](https://user-images.githubusercontent.com/79700810/198209661-627ffc0a-aa1d-47b3-a19d-9c0da3791543.png)

![image](https://user-images.githubusercontent.com/79700810/198209669-52fe4a29-2ee3-4569-9a40-325743910c56.png)

![image](https://user-images.githubusercontent.com/79700810/198209688-1b4d4796-69c4-453d-94b2-fc872f613507.png)

![image](https://user-images.githubusercontent.com/79700810/198209735-3f7d74ad-c19e-4c7e-96a5-748aa04b0db6.png)

![image](https://user-images.githubusercontent.com/79700810/198209751-a2678aac-6cb9-47b1-8539-6664f5639612.png)

![image](https://user-images.githubusercontent.com/79700810/198209763-ff433b02-9cd6-4bdb-a094-20fdf4d70674.png)

![image](https://user-images.githubusercontent.com/79700810/198209782-36802a6c-a812-493c-8218-6dba1dace321.png)

![image](https://user-images.githubusercontent.com/79700810/198209793-a9f74cb2-ede8-4968-bf2f-66f59fa3b093.png)


![image](https://user-images.githubusercontent.com/79700810/198209812-062dc9c3-924f-4038-9e9c-af643d465040.png)


![image](https://user-images.githubusercontent.com/79700810/198209830-41ac1661-6a29-4539-bb49-79d3ae8e805e.png)

![image](https://user-images.githubusercontent.com/79700810/198209859-d568a358-2194-45df-a2be-c8430dfebb31.png)

![image](https://user-images.githubusercontent.com/79700810/198209869-4588de0a-e1df-4a82-a197-0ebed7f5a839.png)

![image](https://user-images.githubusercontent.com/79700810/198209891-d26b22c8-3a1c-4945-b52b-3d927fe42b0f.png)


### Настройка шаблона для клонирования 

![image](https://user-images.githubusercontent.com/79700810/198210357-08abe0c4-9b9e-4af1-a546-ee5426e564a8.png)

![image](https://user-images.githubusercontent.com/79700810/198210549-754cf55c-a378-4ad4-ac49-c69ce1cb92ca.png)

Убедиться, что файл /etc/apt/sources.list содержит следующие строки,
при необходимости — добавить, если имеются другие записи, то закомментировать их или удалить

```
nano /etc/apt/sources.list
```

```
deb http://download.astralinux.ru/astra/frozen/1.7_x86-64/1.7.1/repository-base 1.7_x86-64 main non-free contrib

deb http://download.astralinux.ru/astra/frozen/1.7_x86-64/1.7.1/repository-extended 1.7_x86-64 main contrib non-free
```

![image](https://user-images.githubusercontent.com/79700810/198210691-b91d3586-963f-4f4b-b48b-00bcb59a7780.png)

подключить репозиторий aldpro, выполнив в терминале команды

```
echo -e "deb https://download.astralinux.ru/aldpro/stable/repository-main/ 1.0.0 main" | sudo tee /etc/apt/sources.list.d/aldpro.list

echo -e "deb https://download.astralinux.ru/aldpro/stable/repository-extended/ generic main" | sudo tee -a /etc/apt/sources.list.d/aldpro.list
```

![image](https://user-images.githubusercontent.com/79700810/198211039-745b7244-1159-4838-a977-9d308a84344c.png)


добавить конфигурационный файл /etc/apt/preferences.d/aldpro настроек приоритета apt со следующим содержимым:

```
nano /etc/apt/preferences.d/aldpro
```

```
Package: *
Pin: release n=generic
Pin-Priority: 900
```

![image](https://user-images.githubusercontent.com/79700810/198211110-9fa548fb-38a2-4614-a383-fe141de33ba6.png)


обновить пакеты, выполнив в терминале команду

```
apt update
apt upgrade
```


```
apt install -y open-vm-tools
```


![image](https://user-images.githubusercontent.com/79700810/198218196-a81bf25a-ec29-44e9-ad58-6b42be1e9ce4.png)

На сервере, подготовленном для развертывания контроллера домена, необходимо
выполнить в терминале команду

```
DEBIAN_FRONTEND=noninteractive apt-get install -q -y aldpro-mp
```


### Создание изолированного сегмента сети

![image](https://user-images.githubusercontent.com/79700810/198565009-e968e654-57b1-4894-9279-c533ffeb9bcf.png)

![image](https://user-images.githubusercontent.com/79700810/198565048-751dc557-f38a-4076-9f88-ff8dead77df5.png)

![image](https://user-images.githubusercontent.com/79700810/198565116-1a912541-7eae-426e-9a7a-e3f7177d4fdf.png)

![image](https://user-images.githubusercontent.com/79700810/198565146-af0e9533-2d2a-4fcf-a5e2-1fd1d17f9607.png)



### Настройка трафика

![image](https://user-images.githubusercontent.com/79700810/198565366-b6c19478-b8ff-4ca1-b336-458acc57a072.png)

![image](https://user-images.githubusercontent.com/79700810/198565428-adf44227-603a-4699-8702-734a631f28fb.png)


### Создание виртуальный машины DC1 из шаблона 

![image](https://user-images.githubusercontent.com/79700810/198517553-86aea054-cd50-4613-96f4-34986e6ab5fa.png)


![image](https://user-images.githubusercontent.com/79700810/198517829-ce1d18b6-e7f2-4c51-9677-f74f08b62817.png)

![image](https://user-images.githubusercontent.com/79700810/198517944-fe0302b2-cb18-4ac3-aff0-9837d4be45d5.png)

![image](https://user-images.githubusercontent.com/79700810/198517986-2807697a-9082-4d21-a8b9-0c98df9a7378.png)

![image](https://user-images.githubusercontent.com/79700810/198518104-4314a8d6-df4d-4218-96a1-867c96e0fee1.png)

Добавляем второй интерфейс

![image](https://user-images.githubusercontent.com/79700810/198518159-cb543bf8-84bd-4862-859e-4705d8a9bc67.png)


!!!!!!!!!!!!!!!!!!!!
### DC1
!!!!!!!!!!!!!!!!!!!!
```
nano /etc/hostname
```

```
dc1.domain.test
```

![image](https://user-images.githubusercontent.com/79700810/198520511-77ce0590-9ee4-4fd4-a14e-6a6dd000a0e8.png)


```
nano /etc/hosts
```

```
127.0.0.1 localhost.localdomain localhost
172.30.10.10 dc1.domain.test dc1
127.0.1.1 dc1
```


![image](https://user-images.githubusercontent.com/79700810/198520541-60d40950-91fd-4b56-9d94-c48a332df2ab.png)


```
nano /etc/resolv.conf

```

```
search domain.test
nameserver 127.0.0.1
```

![image](https://user-images.githubusercontent.com/79700810/198520640-079c92c9-4ca3-4d6f-8386-897578f5c777.png)


```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth1
iface eth1 inet static
address 172.30.10.10
netmask 255.255.255.0
dns-nameservers 127.0.0.1
dns-search domain.test


auto eth0
iface eth0 inet static
address 172.30.66.24
netmask 255.255.255.0
gateway 172.30.66.1
```

![image](https://user-images.githubusercontent.com/79700810/198520716-97af4b73-d2d6-4b18-b914-7f875bb661ab.png)


```
systemctl restart networking
```
```
sudo /opt/rbta/aldpro/mp/bin/aldpro-server-install.sh -d domain.test -n dc1 -p Passw0rd --ip 172.30.10.10 --no-reboot
```

```
reboot
```

```
iptables -t nat -A POSTROUTING -o eth0  -j MASQUERADE
```

```
nano /etc/sysctl.conf
```

```
net.ipv4.ip_forward=1
```

![image](https://user-images.githubusercontent.com/79700810/198520843-0c64a584-e20e-4922-8724-99406e0241fa.png)

```
sysctl -p
```

![image](https://user-images.githubusercontent.com/79700810/198518839-010cb036-16ed-4c78-918e-ec72a68eb827.png)



### Создание виртуальный машины DC2 из шаблона

![image](https://user-images.githubusercontent.com/79700810/198517553-86aea054-cd50-4613-96f4-34986e6ab5fa.png)


![image](https://user-images.githubusercontent.com/79700810/198517829-ce1d18b6-e7f2-4c51-9677-f74f08b62817.png)

![image](https://user-images.githubusercontent.com/79700810/198537903-9a7b4f97-b9ba-4144-ab62-55fe8da0ac0a.png)


![image](https://user-images.githubusercontent.com/79700810/198517986-2807697a-9082-4d21-a8b9-0c98df9a7378.png)

![image](https://user-images.githubusercontent.com/79700810/198518104-4314a8d6-df4d-4218-96a1-867c96e0fee1.png)

Меняем интерфейс на VLAN10
![image](https://user-images.githubusercontent.com/79700810/198537984-ef9be891-3549-4881-b868-91b0550c28b0.png)


!!!!!!!!!!!!!!!!!!!!
### DC2
!!!!!!!!!!!!!!!!!!!!

```
nano /etc/hostname
```

```
dc2.domain.test
```

```
nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 dc2
```

```
nano /etc/resolv.conf
```

```
search domain.test
nameserver 172.30.10.10
```

```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth0
iface eth0 inet static
address 172.30.10.11
netmask 255.255.255.0
gateway 172.30.10.10
dns-nameservers 172.30.10.10
dns-search domain.test
```

```
systemctl restart networking
```

```
sudo /opt/rbta/aldpro/client/bin/aldpro-client-installer -c domain.test -u admin -p Passw0rd -d dc2 -i -f
```

```
reboot
```


После перезагрузки на DC1

![image](https://user-images.githubusercontent.com/79700810/198519150-7e5dc3b1-1812-48da-9810-2bc72aaafc6e.png)


Настройка дополнительного контроллера домена

![image](https://user-images.githubusercontent.com/79700810/198523686-5050e83d-e889-413c-9350-ce44c8f647a5.png)

![image](https://user-images.githubusercontent.com/79700810/198523818-d8b2f20a-d27e-4dd9-af53-6a9bd719df26.png)

Выберете сервер и нажмите сохранить

![image](https://user-images.githubusercontent.com/79700810/198523974-ca9a8024-b629-47d7-9bcc-eac0c6953fd9.png)



!!!!!!!!!!!!!!!!!!!!
### AUDIT
!!!!!!!!!!!!!!!!!!!!

```
nano /etc/hostname
```

```
audit.domain.test
```

![image](https://user-images.githubusercontent.com/79700810/198525464-82a0a7c6-b083-4db3-ba81-bf9c7f9e11e7.png)


```
nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 audit
```



![image](https://user-images.githubusercontent.com/79700810/198525625-ec7ba768-5abe-4e98-b213-61a45b5b3574.png)


```
nano /etc/resolv.conf
```

```
search domain.test
nameserver 172.30.10.10
```

![image](https://user-images.githubusercontent.com/79700810/198525770-918bc968-4338-497f-a43a-b1a1c99d9ae3.png)


```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth0
iface eth0 inet static
address 172.30.10.12
netmask 255.255.255.0
gateway 172.30.10.10
dns-nameservers 172.30.10.10
dns-search domain.test
```

![image](https://user-images.githubusercontent.com/79700810/198526053-914802d3-d57a-4f40-b7df-69efd1756756.png)



```
systemctl restart networking
```

```
sudo /opt/rbta/aldpro/client/bin/aldpro-client-installer -c domain.test -u admin -p Passw0rd -d audit -i -f
```

```
reboot
```


Настройка журнала событий

![image](https://user-images.githubusercontent.com/79700810/198526559-31c051c1-55d7-48a7-8c0b-5d4436d3861a.png)


![image](https://user-images.githubusercontent.com/79700810/198532715-76bc415d-8160-4906-9fef-ef3fc7a0294c.png)

Настройка правил

![image](https://user-images.githubusercontent.com/79700810/198533519-de259a6f-0d00-4d5e-8c2c-3db98b7a3312.png)

![image](https://user-images.githubusercontent.com/79700810/198533660-f74e7c4e-f4aa-405e-85c4-000186400d9c.png)


![image](https://user-images.githubusercontent.com/79700810/198533786-246cdd4a-59ad-4a16-9f62-c2cef8df7bdb.png)



!!!!!!!!!!!!!!!!!!!!
### MON
!!!!!!!!!!!!!!!!!!!!

```
nano /etc/hostname
```

```
mon.domain.test
```

```
nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 mon
```

```
nano /etc/resolv.conf
```

```
search domain.test
nameserver 172.30.10.10
```

```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth0
iface eth0 inet static
address 172.30.10.13
netmask 255.255.255.0
gateway 172.30.10.10
dns-nameservers 172.30.10.10
dns-search domain.test
```

```
systemctl restart networking
```

```
sudo /opt/rbta/aldpro/client/bin/aldpro-client-installer -c domain.test -u admin -p Passw0rd -d mon -i -f
```

```
reboot
```


Настройка Мониторинга 

![image](https://user-images.githubusercontent.com/79700810/198533150-112e367f-f2aa-42f4-9538-586faff64cfb.png)


![image](https://user-images.githubusercontent.com/79700810/198533285-5e9ef0c4-9abb-4fea-a760-fa121d14d401.png)


![image](https://user-images.githubusercontent.com/79700810/198533351-539d8f33-db4a-4110-9553-c091a6797fe0.png)



![image](https://user-images.githubusercontent.com/79700810/198540487-7b74c8f4-2ea5-4129-ab3c-c5b8469ae712.png)


!!!!!!!!!!!!!!!!!!!!
### SMB
!!!!!!!!!!!!!!!!!!!!

```
nano /etc/hostname
```

```
smb.domain.test
```

```
nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 smb
```

```
nano /etc/resolv.conf
```

```
search domain.test
nameserver 172.30.10.10
```

```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth0
iface eth0 inet static
address 172.30.10.14
netmask 255.255.255.0
gateway 172.30.10.10
dns-nameservers 172.30.10.10
dns-search domain.test
```

```
systemctl restart networking
```

```
sudo /opt/rbta/aldpro/client/bin/aldpro-client-installer -c domain.test -u admin -p Passw0rd -d smb -i -f
```

```
reboot
```



Настройка общего доступа к файлам

![image](https://user-images.githubusercontent.com/79700810/198535578-60fe8b34-ebcd-40c7-a1e0-b7204b3ccfcf.png)


![image](https://user-images.githubusercontent.com/79700810/198535718-b76baa3c-079e-4d25-baf6-9ef48187f620.png)


![image](https://user-images.githubusercontent.com/79700810/198535772-be50c802-d623-4be6-8fe9-5cc106f81698.png)


Настройка прав на общей ресурс

![image](https://user-images.githubusercontent.com/79700810/198535992-8a0f1871-87ec-41ef-9f6d-d6156d75671a.png)

![image](https://user-images.githubusercontent.com/79700810/198536190-fe935f2a-6d8f-4398-81eb-21fd73fe8a15.png)

![image](https://user-images.githubusercontent.com/79700810/198536253-c3a55ee8-8077-4863-b6c3-1f521886217b.png)

![image](https://user-images.githubusercontent.com/79700810/198536508-85793be3-a6f5-4e6b-9a1c-a4f946be5827.png)


![image](https://user-images.githubusercontent.com/79700810/198536373-cd9df3b0-68a3-4d1f-9582-571ca21d32b9.png)


На пользователя

![image](https://user-images.githubusercontent.com/79700810/198536662-336cd431-fbc1-4851-b15a-2a89cf1852b1.png)

На группу 
![image](https://user-images.githubusercontent.com/79700810/198536992-14858095-8e16-4970-b130-e35bba667be1.png)



Итог 
![image](https://user-images.githubusercontent.com/79700810/198536893-58d7d2ca-b3a6-4b3a-9ce5-10ecdece0bd2.png)




### Управление организационной структурой подразделениями


![image](https://user-images.githubusercontent.com/79700810/198543644-e5821ea2-7080-45d7-936c-9bfab18e50e3.png)


Создание подразделения

![image](https://user-images.githubusercontent.com/79700810/198543860-890e3701-0430-408b-aa6e-a18190a80f4c.png)


![image](https://user-images.githubusercontent.com/79700810/198543980-c1940813-7594-42df-b7ec-a1b9a7fe27ec.png)


Создание пользователей в подразделении

![image](https://user-images.githubusercontent.com/79700810/198544399-7f92359b-874d-4ee6-8dac-48942790f1f8.png)


![image](https://user-images.githubusercontent.com/79700810/198544615-0415132c-d320-400c-a2a2-db2a00d92aef.png)


Создание группы в подразделении

![image](https://user-images.githubusercontent.com/79700810/198544668-b0c3d549-6237-43e6-a667-2faa1dae4807.png)


![image](https://user-images.githubusercontent.com/79700810/198544792-9b96f15f-99e5-4293-b92f-4fc48861fb18.png)

Добавление пользователя в группу

![image](https://user-images.githubusercontent.com/79700810/198544903-bb12d9cf-5a03-43fd-a940-352ccac89d38.png)

### Управление групповыми политиками

![image](https://user-images.githubusercontent.com/79700810/198545620-7a46f4b3-edca-415d-9f39-56a1ca113363.png)



![image](https://user-images.githubusercontent.com/79700810/198545760-9d089f59-666d-42b1-a28a-86b39651aaac.png)

Политика на пользователя

![image](https://user-images.githubusercontent.com/79700810/198546301-9e6d44ab-bbe0-46e0-93d7-593de2ea19c4.png)

Подсказки заполнения полей

![image](https://user-images.githubusercontent.com/79700810/198546412-b9704c54-50c7-4951-a84b-9010ff6963f9.png)

![image](https://user-images.githubusercontent.com/79700810/198546821-6c54f056-7732-450e-9610-acb948d18a5f.png)

![image](https://user-images.githubusercontent.com/79700810/198546965-ba488c92-519e-4b9e-ac1d-697e7d9d105d.png)


таргетирование на подразделение

![image](https://user-images.githubusercontent.com/79700810/198547329-c088b6ca-2d79-4e78-9575-c4b8a1c30aa7.png)

![image](https://user-images.githubusercontent.com/79700810/198547402-ed017db1-eda3-442a-938d-f8b67f90fbd2.png)


Создание группы компьютеров 

![image](https://user-images.githubusercontent.com/79700810/198569025-55a10364-ad99-40a1-8d8d-f3584bf3b437.png)

![image](https://user-images.githubusercontent.com/79700810/198569110-51a4ebb5-eef1-4533-a779-9b037caa8820.png)


![image](https://user-images.githubusercontent.com/79700810/198569427-42933005-2a10-4f7f-aea6-c8d9ff310f24.png)

Добавление компьютеров в группу

![image](https://user-images.githubusercontent.com/79700810/198569515-7e103271-f2a0-4a3d-9034-ba3d3c174289.png)


Создание групповой политики для компьютера 


![image](https://user-images.githubusercontent.com/79700810/198573408-a39eb773-9076-4b91-80ed-6ce643900953.png)


![image](https://user-images.githubusercontent.com/79700810/198573351-fa18abf8-94df-4fd1-9bda-d17ae6c0bb23.png)

Таргетирование на подразделение

![image](https://user-images.githubusercontent.com/79700810/198573488-9214d188-fa6a-429f-87d9-044f6df906bd.png)



### Базы данных по аналогии DB1/WEB/DB2/WEB/DB3/WEB/JEN/Client1
!!!!!!!!!!!!!!!!!!!!
DB1
!!!!!!!!!!!!!!!!!!!!

```
nano /etc/hostname
```

```
db1.domain.test
```

```
nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 db1
```

```
nano /etc/resolv.conf
```

```
search domain.test
nameserver 172.30.10.10
```

```
systemctl stop network-manager
systemctl disable network-manager
```

```
nano  /etc/network/interfaces
```

```
auto eth0
iface eth0 inet static
address 172.30.10.15
netmask 255.255.255.0
gateway 172.30.10.10
dns-nameservers 172.30.10.10
dns-search domain.test
```

```
systemctl restart networking
```

```
sudo /opt/rbta/aldpro/client/bin/aldpro-client-installer -c domain.test -u admin -p Passw0rd -d db1 -i -f
```

```
reboot
```


