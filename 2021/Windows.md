## Лабараторная работа 1
Разработчик предоставил вам приложение, которое необходимо для тестирование развернуть на вашей инфраструктуре под управление Windows 

 ⁃ Приложение написано на .net 
 ⁃ Использует entity framework
 ⁃ Использует локальные пути

Версия SDK: не ниже 5.0
Версия EntityFramework: не ниже 3.1.3

## Общие требования 

 ⁃ приложение должно быть доступно по адресу http://lorrylogapi.ht2021.local:5001/vehicles и ip адресу http://172.30.0.3:5001/vehicles 

 ⁃ Доступ к базе данных должен осуществляться через централизованно управляемую учетную запись lorries@ht2021.local 

 ⁃ Приложение должно быть запущенна на разных серверах пользователь lorries@ht2021.local должен иметь локальный доступ и управляться централизовано

 ⁃ Все изменения приложения должны быть добавлены с систему контроля версий


![webL1L2-Page-4 drawio](https://user-images.githubusercontent.com/79700810/135600652-d9a7a35d-3ef3-433d-b012-7cfa0e54b2c9.png)


## Базовая конфигурация
|AD             |BD             |APP             |DEV1           |DEV2           |
| ------------- | ------------- | ------------- |    ------------- |  ------------- | 
|Windows Server 2019 GUI |Windows Server 2019 GUI   |Windows Server 2019 Core|Windows 10           |Ubuntu           |
|Administartor |Administartor   |Administartor|Admin           |user           |
|Pa$$w0rd |Pa$$w0rd  |Pa$$w0rd|Pa$$w0rd          |Pa$$w0rd           |

## Основные службы 
- Active directory
- DNS
- DHCP
- Certificate Services
- MSSQL
- Dotnet

## на Виртуальной машине AD

В строке поиска указываем Powershell и запускаем его от имени администратор 

![image](https://user-images.githubusercontent.com/79700810/135076082-526bacb5-788e-41e1-97b6-478b23334b2e.png)

Для изменения имени виртуальной машины указываем новое имя
```powershell
Rename-Computer -NewName AD
```

Результат команды (изменения вступят в силу после перезагрузки виртуальной машины)
![image](https://user-images.githubusercontent.com/79700810/135077764-128c6a5b-8b49-4233-ab01-28a4adff3ca7.png)

Для назначение сетевых конфигураций необходимо определить индек интерфейса
```powershell
Get-NetAdapter
```

Результат команды (в данном случае идентификатор имеет значение 4)
![image](https://user-images.githubusercontent.com/79700810/135076517-7ec62953-499f-4821-8ac5-ffa8ef9d131b.png)

Назначаем IP адрес, маску, шлюз по умолчанию
```powershell
New-NetIPAddress -InterfaceIndex 4 -IPAddress 172.30.0.1 -PrefixLength 24 -DefaultGateway 172.30.0.254
```
Результат команды (назначение статических настроек сетевого интерфейса)
![image](https://user-images.githubusercontent.com/79700810/135076786-53aec8d7-1fc0-41e7-bb60-5debdc0b2e8c.png)

добавление DNS серверов (виртуальная машина AD будет являться корневым контролерам домена, а также DNS сервером)
```powershell
Set-DnsClientServerAddress -InterfaceIndex 4 -ServerAddresses ("172.30.0.1","8.8.8.8")
```
Результат команды изменениям DNS
![image](https://user-images.githubusercontent.com/79700810/135077615-686de7e6-d3d2-4b27-9e3d-59abc1705324.png)

В случае необходимости команда изменения времени (после установки контролера домена автоматически будет настроен сервер времени для всех клиентов внутри домена)
```powershell
Set-date -date "01/10/2021 9:38"
```
Результат команды времени
![image](https://user-images.githubusercontent.com/79700810/135576509-4e426ac0-a393-49ba-9f39-6e788fe5b66d.png)

Команда изменения часового пояса (штатной трансляции изменения часового пояса централизовано нет, является клиентской настройкой)
```powershell
Set-TimeZone -Id "Russian Standard Time"
```
Результат команды изменяя часового пояса
![image](https://user-images.githubusercontent.com/79700810/135077137-a6b43163-7ea7-4fb2-9e33-c555f1d03037.png)

Настройка правил межсетевого экрана (разрешение трафика ICMP)

```powershell
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
```

Результат команды создание правила
![image](https://user-images.githubusercontent.com/79700810/135084032-127b3938-8887-43af-b922-407d02f7f7e0.png)

Команда для перезагрузки виртуальной машины 
```powershell
Restart-Computer
```

## на Виртуальной машине BD

По аналогии с AD задаем имя виртуальной машине
```powershell
Rename-Computer -NewName BD
```

Результат команды
![image](https://user-images.githubusercontent.com/79700810/135078689-e391018d-d787-46c0-b9a0-099bd68d2488.png)

В данном случае будем использовать переменную $GetIndex для определения индекса сетевого адаптера
```powershell
$GetIndex = Get-NetAdapter 
New-NetIPAddress -InterfaceIndex $GetIndex.ifIndex -IPAddress 172.30.0.2 -PrefixLength 24 -DefaultGateway 172.30.0.254
```

Результат команды (назначение статических настроек сетевого интерфейса)
![image](https://user-images.githubusercontent.com/79700810/135078577-974c7ced-0520-4c8b-abf4-086b6e8099a4.png)

добавление DNS серверов
```powershell
Set-DnsClientServerAddress -InterfaceIndex $GetIndex.ifIndex -ServerAddresses ("172.30.0.1","8.8.8.8")
```

Результат команды измененемя DNS
![image](https://user-images.githubusercontent.com/79700810/135078826-7608a631-22a0-4d47-b7d4-d3aa392dcb35.png)

Команда изменения часового пояса
```powershell
Set-TimeZone -Id "Russian Standard Time"
```

Результат команды изменяя часового пояса
![image](https://user-images.githubusercontent.com/79700810/135079028-814169e5-4aa6-49a4-9004-0ed185bce153.png)

Настройка правил межсетевого экрана (разрешение трафика ICMP)
```powershell
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
```

Результат команды создание правила
![image](https://user-images.githubusercontent.com/79700810/135084143-03aec0f0-07a3-4919-b70f-d9c7d3bf1400.png)

Команда для перезагрузки виртуальной машины
```powershell
Restart-Computer
```

## на Виртуальной машине APP

![image](https://user-images.githubusercontent.com/79700810/135079269-d193157f-3d1c-4bdf-b12e-c9a29c51ad52.png)

данная виртуальная машина не имеет графического интерфейса (запускаем powershell)
```powershell
Rename-Computer -NewName APP
$GetIndex = Get-NetAdapter 
New-NetIPAddress -InterfaceIndex $GetIndex.ifIndex -IPAddress 172.30.0.3 -PrefixLength 24 -DefaultGateway 172.30.0.254
Set-DnsClientServerAddress -InterfaceIndex $GetIndex.ifIndex -ServerAddresses ("172.30.0.1","8.8.8.8")
Set-TimeZone -Id "Russian Standard Time"
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
Restart-Computer
```

## Конфигурация всех виртуальных машин в powershell

AD

```powershell
Rename-Computer -NewName AD
$GetIndex = Get-NetAdapter 
New-NetIPAddress -InterfaceIndex $GetIndex.ifIndex -IPAddress 172.30.0.1 -PrefixLength 24 -DefaultGateway 172.30.0.254
Set-DnsClientServerAddress -InterfaceIndex $GetIndex.ifIndex -ServerAddresses ("172.30.0.1","8.8.8.8")
Set-TimeZone -Id "Russian Standard Time"
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
Restart-Computer
```
BD

```powershell
Rename-Computer -NewName BD
$GetIndex = Get-NetAdapter 
New-NetIPAddress -InterfaceIndex $GetIndex.ifIndex -IPAddress 172.30.0.2 -PrefixLength 24 -DefaultGateway 172.30.0.254
Set-DnsClientServerAddress -InterfaceIndex $GetIndex.ifIndex -ServerAddresses ("172.30.0.1","8.8.8.8")
Set-TimeZone -Id "Russian Standard Time"
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
Restart-Computer
```
APP

```powershell
Rename-Computer -NewName APP
$GetIndex = Get-NetAdapter 
New-NetIPAddress -InterfaceIndex $GetIndex.ifIndex -IPAddress 172.30.0.3 -PrefixLength 24 -DefaultGateway 172.30.0.254
Set-DnsClientServerAddress -InterfaceIndex $GetIndex.ifIndex -ServerAddresses ("172.30.0.1","8.8.8.8")
Set-TimeZone -Id "Russian Standard Time"
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
Restart-Computer
```

## Проверка c AD

Проверка коннективности

![image](https://user-images.githubusercontent.com/79700810/135084339-b734e3aa-8948-48ed-b21d-89450149fc36.png)


## Установка контролера домена на AD

Установка роли Active directory и необходимых компонентов управления
```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```
Результат команды установки роли
![image](https://user-images.githubusercontent.com/79700810/135089113-45590dc5-2691-435d-b07e-21dcc331a611.png)

Создание домена ht2021.local и установка DNS сервера
```powershell
Install-ADDSForest -DomainName "ht2021.local" -InstallDNS
```
Результат команды 
![image](https://user-images.githubusercontent.com/79700810/135086754-285e1bd2-59b4-45a0-adc9-79c4a574b083.png)


  ## Установка и настройка DNS

Добавление обратной зоны просмотра на DNS сервере 
```powershell
Add-DnsServerPrimaryZone -NetworkId 172.30.0.0/24 -ReplicationScope Domain
```

Результат команды 
![image](https://user-images.githubusercontent.com/79700810/135089385-f9b18d69-4c0d-40d9-a100-4a3fc80be898.png)

В прямой зоне DNS находится запись ad.ht2021.local (добавим в обратную зону)
```powershell
Add-DNSServerResourceRecordPTR -ZoneName 0.30.172.in-addr.arpa -PTRDomainName ad.ht2021.local -Name 1
```
Результат команды добавления в обрадую зону
![image](https://user-images.githubusercontent.com/79700810/135096456-2d31bd18-bbc2-4b55-b035-d9a0055ca8a2.png)

Создание записи типа A для приложения в прямой и обратной зоне DNS
```powershell
Add-DnsServerResourceRecordA -Name "lorrylogapi" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.3" -CreatePtr 
```
Результат команды добавления записи
![image](https://user-images.githubusercontent.com/79700810/135402777-83c63a4d-2c80-4fe1-ab59-277ae025e17b.png)


  ## Проверка AD и DNS
В Server Manager во вкладке Tools переходим в Active directory users and computers и DNS
![image](https://user-images.githubusercontent.com/79700810/135211673-ed82d9e5-0646-4672-be7e-c1f19d1fd47c.png)

## Конфигурация active directory и DNS в powershell
```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "ht2021.local" -InstallDNS
Add-DnsServerPrimaryZone -NetworkId 172.30.0.0/24 -ReplicationScope Domain
Add-DNSServerResourceRecordPTR -ZoneName 0.30.172.in-addr.arpa -PTRDomainName ad.ht2021.local -Name 1
Add-DnsServerResourceRecordA -Name "lorrylogapi" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.3" -CreatePtr 
```

## Установка и настройка DHCP сервера на AD

Установка роли DHCP и необходимых компонентов управления
```powershell
Install-WindowsFeature -Name DHCP -IncludeManagementTools
```
Результат команды установки роли DHCP
![image](https://user-images.githubusercontent.com/79700810/135211808-5c33709a-d592-4784-9f60-2bef6c36b92f.png)

После установки необходимо Авторизовать DHCP сервер в Active Directory (укажите DNS имя сервера и IP адрес, который будет использоваться DHCP клиентами)
```powershell
Add-DhcpServerInDC -DnsName ad.ht2021.local -IPAddress 172.30.0.1
```

Результат команды авторизации
![image](https://user-images.githubusercontent.com/79700810/135213223-c5d40c20-221a-4a3f-8787-ac3ce268cb41.png)

Чтобы Server Manager перестал показывать уведомление о том, что DHCP роль требует настройки, выполните команду
```powershell
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
```

Перезапустите службу DHCPServer:
```powershell
Restart-Service -Name DHCPServer -Force
```
Результат команды перезагрузки
![image](https://user-images.githubusercontent.com/79700810/135213462-a33e9765-4c95-4986-9067-fa81849374b3.png)

Создание DHCP пула для выдачи адресов и активация 
```powershell
Add-DhcpServerv4Scope -Name DHCPHT -StartRange 172.30.0.101 -EndRange 172.30.0.110 -SubnetMask 255.255.255.0 -State Active
```
Результат команды создание пула
![image](https://user-images.githubusercontent.com/79700810/135213584-b692175b-d318-40c5-afc4-c364b9b4b128.png)

Настройка дополнительных опций (DNS серверов)
```powershell
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 6 -Value "172.30.0.1","8.8.8.8"
```
Результат добавление опций DNS серверов
![image](https://user-images.githubusercontent.com/79700810/135213840-d0ec6b72-1e87-4c87-9df7-4c74fc8d4872.png)

Настройка дополнительных опций (шлюз по умолчанию)
```powershell
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 3 -Value "172.30.0.254"
```
Результат добавление основного шлюза
![image](https://user-images.githubusercontent.com/79700810/135214157-ee7d8f67-1408-4cef-8d7d-01883f8a61de.png)

Настройка дополнительных опций (суффикс)
```powershell
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 15 -Value "ht2021.local"
```
Результат добавление суффикса
![image](https://user-images.githubusercontent.com/79700810/135214354-7a77a647-5a7e-491e-b427-b2bc0acaf63d.png)

## Проверка DHCP
В Server Manager во вкладке Tools переходим в DHCP
![image](https://user-images.githubusercontent.com/79700810/135214432-9e49bda1-c6ae-4810-afb0-353557790409.png)

## Конфигурация DHCP в powershell
```powershell
Install-WindowsFeature -Name DHCP -IncludeManagementTools
Add-DhcpServerInDC -DnsName ad.ht2021.local -IPAddress 172.30.0.1
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
Restart-Service -Name DHCPServer -Force
Add-DhcpServerv4Scope -Name DHCPHT -StartRange 172.30.0.101 -EndRange 172.30.0.110 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 6 -Value "172.30.0.1","8.8.8.8"
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 3 -Value "172.30.0.254"
Set-DhcpServerv4OptionValue -ScopeId 172.30.0.0 -OptionId 15 -Value "ht2021.local"
```

## Настройка элементов active directory
  
Создание подразделения (OU)
```powershell
New-ADOrganizationalUnit -Name "OUBD" -Path "DC=ht2021, DC=local"
```
Результат команды создание OU
![image](https://user-images.githubusercontent.com/79700810/135214867-a588094d-20e4-405b-b0d2-259c5051b994.png)

Создание группы безопасности
```powershell
New-ADGroup -Name "BD" -Path "OU=OUBD, DC=ht2021, DC=local" -GroupScope Global -SamAccountName BD
```

Результат команды создание группы безопасности
![image](https://user-images.githubusercontent.com/79700810/135214997-fd4943f0-da1b-42ae-8830-64e1b7f051b8.png)

Создание пользователя 
```powershell
New-ADUser -Name lorries -Enabled $true -Path 'OU=OUBD,DC=ht2021, DC=local' -AccountPassword (ConvertTo-SecureString -String 'Pa$$w0rd' -AsPlainText -Force) -UserPrincipalName lorries@ht2021.local -PasswordNeverExpires $true 
```

Результат команды создание пользователя
![image](https://user-images.githubusercontent.com/79700810/135218499-7ef57c02-0fc0-46cf-86e2-ca0fc21bb0b9.png)

Добавление пользователя в группу безопасности
```powershell
Add-ADGroupMember -Identity BD -Members lorries
```
Результат команды добавления пользователя в группу безопасности
![image](https://user-images.githubusercontent.com/79700810/135218611-74776adc-b0be-4922-8020-0d28507adf73.png)

## Конфигурация элементов в powershell
```powershell
New-ADOrganizationalUnit -Name "OUBD" -Path "DC=ht2021, DC=local"
New-ADGroup -Name "BD" -Path "OU=OUBD, DC=ht2021, DC=local" -GroupScope Global -SamAccountName BD
New-ADUser -Name lorries -Enabled $true -Path 'OU=OUBD,DC=ht2021, DC=local' -AccountPassword (ConvertTo-SecureString -String 'Pa$$w0rd' -AsPlainText -Force) -UserPrincipalName lorries@ht2021.local -PasswordNeverExpires $true 
Add-ADGroupMember -Identity BD -Members lorries
```

## Создание групповой политики
 
Для запуска приложения и доступу к базе данных пользователь должен обладать провами доступа

В Server Manager во вкладке Tools переходим в group policy management 
Создаем новую GPO задаем ей имя

![image](https://user-images.githubusercontent.com/79700810/135275861-4635c1a3-88dd-4dd5-82a5-d3641570cdcf.png)

Переходим в редактирование затем в Computer Configuration –> Preferences –> Control Panel Settings –> Local Users and Groups далее New -> Local Group

![image](https://user-images.githubusercontent.com/79700810/135276156-4f3b6640-d595-4123-a67d-1ccc8920a17c.png)

В group name выбираем из выпадающего списка Administrators (Built-in) далее на add

![image](https://user-images.githubusercontent.com/79700810/135276221-6b3f8074-4ffa-4d80-9a2b-689abbe8d5a1.png)

Выбираем группу безопасности BD

![image](https://user-images.githubusercontent.com/79700810/135276374-c6686035-50bc-4b3e-873d-30e4489a9a9f.png)

## Проверка пользователя 

В Server Manager во вкладке Tools переходим в Active directory users and computers далее в OU

![image](https://user-images.githubusercontent.com/79700810/135218683-492495ec-5bcb-426a-8897-0581915428d8.png)

## Настройка BD

Присоединения к домену (вводим учетную запись администратора контроллера домена)
```powershell
Add-Computer -DomainName "ht2021.local"
```

Результат команды добавления в домен

![image](https://user-images.githubusercontent.com/79700810/135219110-dd760bf4-ba07-4050-9898-df8f9af9a031.png)

Перезагрузка сервера

```powershell
Restart-Computer
```

Для подключения к базе данных удаленно необходимо разрешить правила в межсетевом экране
Правило TCP на порт 1433
```powershell
New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
```

Результат создание правила TCP

![image](https://user-images.githubusercontent.com/79700810/135220934-1c17e457-1931-411c-adce-e261e91349da.png)

Правило UDP на порт 1433

```powershell
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1434 -Protocol UDP -Action Allow
```

Результат создание правила UDP
![image](https://user-images.githubusercontent.com/79700810/135221149-d182072d-f02d-4b25-a19d-5a7f57a7a91f.png)


## Конфигурация элементов в powershell
```powershell
Add-Computer -DomainName "ht2021.local"
New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1434 -Protocol UDP -Action Allow
Restart-Computer
```
## Установка сервера MSSQL на BD

Запускаем файл exe переходим в custom оставляем путь скачивания по умолчанию

![image](https://user-images.githubusercontent.com/79700810/135219676-8d2ca0e5-387d-4543-bfdc-a67505a1d84c.png)

Выбираем new SQL server 

![image](https://user-images.githubusercontent.com/79700810/135230606-251a4d2f-9142-40d9-a6a7-dbc5d5aacf97.png)

Выбираем необходимые дополнения

![image](https://user-images.githubusercontent.com/79700810/135231100-39d6c692-5a54-4690-afcd-81d165340494.png)

Задаем имя для базой данных

![image](https://user-images.githubusercontent.com/79700810/135231163-beb6ae0f-75c3-43a1-a5f2-54fb3eeff6df.png)

Выбираем способ аунтификации и добавляем группу безопасности BD

![image](https://user-images.githubusercontent.com/79700810/135231356-6f921110-783e-42f9-bd29-b9ef3271a795.png)

Результат успешной установки сервера

![image](https://user-images.githubusercontent.com/79700810/135232205-060c6a4c-f2c3-41a5-89c2-d92da5e3bb09.png)

Менеджер управления можно вызвать в powershell командой 

```
SQLServerManager15.msc
```

TCP/IP выбираем Enabled и задаем порт 1433 для подключения всех клиентов

![image](https://user-images.githubusercontent.com/79700810/135622294-b4e2179f-865a-4115-b723-b539375d39ac.png)

Вслучае необходимости MSSQL сервер можно перезагрузить во вкладке sql server service

![image](https://user-images.githubusercontent.com/79700810/135622444-8ead4b6a-5a63-4c74-be72-4311036b61df.png)


## Настройка клиента DEV1

Клиен должен получить адрес по DHCP с необходимыми опциями добавляем в домен и задаем имя
```powershell
Add-Computer -NewName DEV1 -DomainName "ht2021.local"
```

Команда перезагрузки клиента
```powershell
Restart-Computer
```

После перезагрузки выбираем other user и заходим lorries
![image](https://user-images.githubusercontent.com/79700810/135234607-309ba498-1de5-40c6-a248-f663bf4b0c7f.png)

Запускаем SQL Server Management Studio (SSMS) указываем удаленный сервер для подключения

![image](https://user-images.githubusercontent.com/79700810/135240076-12049d3d-d476-4e78-9c1d-eaf42960cd3f.png)

создаем новый запрос 
![image](https://user-images.githubusercontent.com/79700810/135242031-be0c3827-f9b8-44bf-b442-5a093f886208.png)

Создаем базу данных, создаем таблицу, заносим данные
```sql
create database lorrylog;

use lorrylog;

Create table [dbo].[Vehicle]([Id] [int] identity(1,1) not null,[Name] [nvarchar](50) not null,[License] [nvarchar](10) not null,[Make] [nvarchar](20) not null,[Model] [nvarchar](20) not null,[Year] [smallint] not null,Primary key CLUSTERED([Id] ASC))

Insert into Vehicle ([Name],[License], Make, Model,Year) Values ('Thunderdom', 'MADMAX','Ford', 'Falcon XB Coupe', 1974)

select * from Vehicle
```

## Настройка клиента DEV2

Клиен должен получить адрес по DHCP с необходимыми опциями добавляем в домен и задаем имя
Устанавливаем необходимые пакеты 

```
hostnamectl set-hostname DEV2
apt-get install vim
apt-get install sssd-ad sssd-tools realmd adcli
apt install realmd
```
Результат команды установки пакетов

![image](https://user-images.githubusercontent.com/79700810/135448670-77bf4cad-09c9-47e4-bc29-b1d72658d54d.png)

При помощи любого текстового редактора указываем сервер времени

```
vim /etc/systemd/timesyncd.conf
```

Указываем поставщиком времяни ad.ht2021.local

![image](https://user-images.githubusercontent.com/79700810/135449305-3a6cb4fc-6e93-4bcd-bd6f-592c69084355.png)

Проверяем наличие контролеров домена в сети

```
realm discover
```
Результат команды

![image](https://user-images.githubusercontent.com/79700810/135449383-40f7e1f8-b638-4e4f-9501-507992c885d8.png)

Присоединяем DEV2 к контролеру домена

```
realm join ht2021.local
realm list
```
Результат команды добавления и проверка

![image](https://user-images.githubusercontent.com/79700810/135449633-dcd64aae-b34b-48a2-9796-c5d93f7b9f06.png)

Создание автоматической директории для пользователя (домашней)

```
pam-auth-update --enable mkhomedir
reboot
```

![image](https://user-images.githubusercontent.com/79700810/135449675-1c4c951d-2e18-4537-ae61-aab39a8d3ff6.png)

## Работа с системой контроля версий git

Заходим на сайт GitHub.com (используйте свою учетную запись для входа)
В поиске указываем @storm39mad находим репозиторий hi-tech
![image](https://user-images.githubusercontent.com/79700810/135442198-80415828-b7bc-44b9-894d-f9e7c125df8f.png)

В левом верхнем углу выбираем fork после чего данный репозиторий будет добавлен к вам в профиль 
![image](https://user-images.githubusercontent.com/79700810/135442254-515d7fbd-653c-4355-b28a-c3c76e40f4a6.png)
H

## Работа с системой контроля версий git clone

Переходим в репозиторий далее в code и копируем ссылку для клонирования 
![image](https://user-images.githubusercontent.com/79700810/135442313-a2812500-9360-41ef-a53c-37bf25c3bb0e.png)

На DEV1 в командной строке переходим в диск С и копируем репозиторий

```powershell
cd C:\
git clone https://github.com/SLAVAKP11SS/hi-tech.git
```
![image](https://user-images.githubusercontent.com/79700810/135442609-af82e04e-4af5-4c7a-8335-67cf48973ba0.png)


Открываем проект lorrylogapi в vs code 
![image](https://user-images.githubusercontent.com/79700810/135436103-5cb74ffb-029d-46da-ae7c-5c4014dbfb53.png)


## Работа с приложением

В файле appsettings.json необходимо изменить способ подключения к базе данных 
```
"Server=bd.ht2021.local; Database=LorryLog; Trusted_Connection=True;"
```
![image](https://user-images.githubusercontent.com/79700810/135277610-4c0a60a8-5823-4fa6-80e8-7cf5b504a613.png)

В файле Properties\launchSettings.json необходимо изменить url 
```
"http://172.30.0.3:5001;http://lorrylogapi.ht2021.local:5001"
```
![image](https://user-images.githubusercontent.com/79700810/135402103-bb745ded-3a11-4e53-acc6-c3633fcc5951.png)


## Работа с системой контроля версий git pull

После внесения всех изменений в приложение необходимо запушить его в систему контроля версий 
Для этого в своём профиле на GitHub необходимо перейти в настройки 
![image](https://user-images.githubusercontent.com/79700810/135442971-30957656-bc59-487e-be7c-74077f042e6e.png)

Далее перейти в developer settings и сгенерировать новый токен 
![image](https://user-images.githubusercontent.com/79700810/135439193-330350b9-e33a-49b1-ae61-13c6aa6c9de6.png)

Введите свой пароль от учётной записи GitHub 
![image](https://user-images.githubusercontent.com/79700810/135439334-86d25d36-b72c-4d74-b22d-2db7339f1d0c.png)

Выбираем repo 
![image](https://user-images.githubusercontent.com/79700810/135439403-f2e1a336-e2a6-4e84-a900-34e2d6b016fe.png)

Копируем токен в буфер 
![image](https://user-images.githubusercontent.com/79700810/135439423-74b80a48-844c-45e0-873a-e6beda1324d0.png)

В командной строке powershell (в появившемся окне аунтификации вставляем токен)
```powershell
cd C:\hi-tech 
git add -A
git commit -m “test commit”
git push
```
![image](https://user-images.githubusercontent.com/79700810/135439641-ec0128ec-d877-49cd-9d2a-872cf462b2d3.png)

## APP
Добавляем в домен и перезагружаем 
```powershell
Add-Computer -DomainName "ht2021.local"
Restart-Computer
```
После перезагрузки заходим пользователем lorries устанавливаем git 
![image](https://user-images.githubusercontent.com/79700810/135803246-6566a4f0-1fc9-4ca7-a13a-0175e120288a.png)

 ## Установка GIT 

```powershell
cd c:\software
Git-2.33.0.2-64-bit.exe
```
![image](https://user-images.githubusercontent.com/79700810/135803585-29fde88b-53cb-4215-80c8-b60695b11c55.png)
## Установка dotnet sdk
Устанавливаем dotnet sdk для запуска приложения
```powershell
cd c:\software
dotnet-sdk-5.0.401-win-x64.exe
```
![image](https://user-images.githubusercontent.com/79700810/135803798-051bfdfa-ade0-4402-bb95-8a256cef87be.png)

Добавляем правила в межсетевой экран 
```powershell
New-NetFirewallRule -DisplayName "WebApi default 5001" -Direction Inbound -LocalPort 5001 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "WebApi Browser 5001" -Direction Inbound -LocalPort 5001 -Protocol UDP -Action Allow
```
![image](https://user-images.githubusercontent.com/79700810/135277119-4309f92b-9c51-4440-a5d4-820d5260c9ef.png)
![image](https://user-images.githubusercontent.com/79700810/135277151-ed91d74b-36ad-4fc8-90e4-8915ee9d2493.png)

Перезагружаем сервер 
```powershell
Restart-Computer
```


## Запуск приложения dotnet

Далее делаем клон репозиторий со своей учётной записи с изменённой версией приложения 
![image](https://user-images.githubusercontent.com/79700810/135443641-5231e289-c6f3-4bf8-ad47-2883c4badefd.png)

```
cd c:\ 
git clone https://github.com/SLAVAKP11SS/hi-tech.git
```
![image](https://user-images.githubusercontent.com/79700810/135443831-d574f526-3678-438b-8a33-f53a1f9c686f.png)

```
cd c:\hi-tech\lorrylogapi
dotnet run
```
![image](https://user-images.githubusercontent.com/79700810/135443926-8fe76615-6c31-4e85-835b-a8d3d8407964.png)


## Проверка DEV1

Открываем браузер заходим по ссылке
![image](https://user-images.githubusercontent.com/79700810/135402954-0514daf7-d9dd-418f-9e41-e1186d1c3a26.png)


## Установка центра сертификации

Установка роли AD CS
```powershell
Install-WindowsFeature -Name AD-Certificate, ADCS-Web-Enrollment -IncludeManagementTools
```

Результат установки команды 
![image](https://user-images.githubusercontent.com/79700810/135455898-04ff07b7-4416-48e4-beab-af2bd0527816.png)

Настройка роли AD CS

```powershell
Install-AdcsCertificationAuthority -CAType EnterpriseRootCa -CryptoProviderName "ECDSA_P256#Microsoft Software Key Storage Provider" -KeyLength 256 -HashAlgorithmName SHA256 -CACommonName "RootHT" -force
```

Результат команды настройки

![image](https://user-images.githubusercontent.com/79700810/135458156-bdcb4768-dc14-4dea-b575-ae81719e02d5.png)

В Server Manager во вкладке незаконченных процессах

![image](https://user-images.githubusercontent.com/79700810/135461720-6660d814-5aa9-401c-ba24-c00825918f2e.png)

Выбираем ca web enrollment

![image](https://user-images.githubusercontent.com/79700810/135461761-d40bb5e5-fb6f-4299-9946-1e1111eef44b.png)ю

Коммитим web enrollment

![image](https://user-images.githubusercontent.com/79700810/135461825-f5a79613-50cc-404d-acff-310a098182e9.png)

Далее добавляем необходимые темплейты для будущего использования

![image](https://user-images.githubusercontent.com/79700810/135458420-feb14739-510d-47f1-a45e-497cfeaa5f82.png)
## Создание Группы ресурсов
Необходимо создать бесплатную запить azure на https://portal.azure.com/

В левой части перейти в выпадающей список и выбрать Группы ресурсов далее создать 

выбрать тип подписки, задать имя для группы и регион

![image](https://user-images.githubusercontent.com/79700810/136342571-76c340ef-9a71-48ce-9599-46d9c132e015.png)

## Создание виртуальной сети
В строке поиска перейти в виртуальная сеть

![image](https://user-images.githubusercontent.com/79700810/136342836-f779e95b-bba0-4294-87c9-8462e04df521.png)

выбрать тип подписки, задать имя для группы и регион

![image](https://user-images.githubusercontent.com/79700810/136343168-46c86434-040a-482b-9a3b-3f1dd2874070.png)

Задаем сеть и делаем подсеть 

![image](https://user-images.githubusercontent.com/79700810/136343406-0b9f05e7-26e2-45f2-a20e-bf2af2cba2a8.png)

## Создание виртуальной машины 

Создаем группу ресурсов под виртуальные машины (не обязательно можно использовать уже созданные)
В группе ресурсов переходим в создать и выбираем образ ubuntu

![image](https://user-images.githubusercontent.com/79700810/136343731-367e0116-35f4-4ba5-855e-1d427a6dcb6c.png)

Задаем название, группу, регион выбираем размер (самый минимальный для тестирования)

![image](https://user-images.githubusercontent.com/79700810/136344014-3846045d-f723-431f-b0c3-5c04a29ebe2e.png)

Создаем пользователя и пароль для подключения по ssh

![image](https://user-images.githubusercontent.com/79700810/136344073-fdaa9276-9cbf-4956-9b2c-0895af91976b.png)

Выбираем тип диска HHD (для тестирования)

![image](https://user-images.githubusercontent.com/79700810/136344141-00b2ebdf-f6f1-4692-a9e9-61828082c826.png)

Выбираем заранее созданную подсеть

![image](https://user-images.githubusercontent.com/79700810/136344204-47df978f-c090-425f-8dca-fc537d51671c.png)

После создание на ВМ будет также присвоен общедоступный IP адрес по которому можно получить доступ по ssh

![image](https://user-images.githubusercontent.com/79700810/136344349-b7eefc07-5291-4b9d-9c55-2fe3419ef7f6.png)

## Создание простого веб приложения azure
В строке поиска перейти в службу приложений

![image](https://user-images.githubusercontent.com/79700810/135820901-9b327ee8-c9bd-4337-994c-f887189c5dd2.png)

При создании новой службы приложений необходимо выбрать группу ресурсов (создать новую)
Задать имя по которому будет доступно приложение и стек 

![image](https://user-images.githubusercontent.com/79700810/135820923-6853b56a-2be5-40f0-848d-d292222593fd.png)

Далее необходимо выбрать план 

![image](https://user-images.githubusercontent.com/79700810/135820971-56f53a76-1f1b-413f-a3d2-f0264e504df2.png)
 

После проверки выбираем создать

![image](https://user-images.githubusercontent.com/79700810/135820991-9c52843a-4f77-43b2-ba54-b4e469f548a4.png)

Процесс создание займет время после чего переходим к ресурсу

![image](https://user-images.githubusercontent.com/79700810/135821097-c70efacb-71af-4cf0-b645-ca1841d015a2.png)

Копируем ссылку в буфер

![image](https://user-images.githubusercontent.com/79700810/135821165-02e1e05e-91fb-4ca7-af7f-0ed4f0b9554b.png)

Переходим по ссылки

![image](https://user-images.githubusercontent.com/79700810/135821401-4655cdde-f35d-46d1-8406-73ad89c3a70c.png)

## Создание простой базы данных в azure

В строке поиска перейти в база данных sql

![image](https://user-images.githubusercontent.com/79700810/135821700-b5a503c9-e353-4455-bb81-c58f6fccafdf.png)

При создании новой ,базы данных необходимо выбрать группу ресурсов (создать новую)
Задать имя по которому будет доступно и создать сервер

![image](https://user-images.githubusercontent.com/79700810/135821848-9c47516c-1730-48e0-b84e-285c9f096abf.png)

Задаем имя сервера логин и пароль от учетной записи

![image](https://user-images.githubusercontent.com/79700810/135822250-32e420c5-37d1-456d-b864-060330228d87.png)

Выбираем оптимальный план 

![image](https://user-images.githubusercontent.com/79700810/135822319-f6934f3c-489d-4957-8b1e-3a90c09fae28.png)

Для тестирования выбираем минимальный план 

![image](https://user-images.githubusercontent.com/79700810/135822406-9678dc22-b181-495d-832f-399c986114a1.png)

После проверки выбираем создать 

![image](https://user-images.githubusercontent.com/79700810/135822463-6e1ec76f-4748-4c74-b501-17f1f7bb70ce.png)

Процесс создание займет время после чего переходим к ресурсу

![image](https://user-images.githubusercontent.com/79700810/135822969-6f466342-c6d8-4c6e-a77d-2c6ee95f8b47.png)

Необходимо настроить правило подключения к базе данных

![image](https://user-images.githubusercontent.com/79700810/135823227-280098f8-d7ed-446e-a4a5-4337fef54f0c.png)

Добавляем правило и сохраняем

![image](https://user-images.githubusercontent.com/79700810/135823372-8b57952f-7d42-4008-8d17-0e3a5c34b27c.png)


Далее переходим в редактор запросов подключаемся и выполняем запрос


```
Create table [dbo].[Vehicle]([Id] [int] identity(1,1) not null,[Name] [nvarchar](50) not null,[License] [nvarchar](10) not null,[Make] [nvarchar](20) not null,[Model] [nvarchar](20) not null,[Year] [smallint] not null,Primary key CLUSTERED([Id] ASC))

Insert into Vehicle ([Name],[License], Make, Model,Year) Values ('Thunderdom', 'MADMAX','Ford', 'Falcon XB Coupe', 1974)

select * from Vehicle

sqlcmd -S 172.30.66.20 -U lorries


SELECT * FROM Vehicle
```
![image](https://user-images.githubusercontent.com/79700810/135828655-9a48126b-76e4-4e0e-abc1-2fe396f095b4.png)



