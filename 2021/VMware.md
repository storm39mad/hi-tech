## Лабораторная работа 2
По результатам тестирование приложения было принято решение создать минимальную кластерную конвергентную инфраструктуру на платформе VMware для автоматизации производства и запуска приложений в docker и kubernetes


## Общие требования 
- Доступ должен осуществляться через единую точку входа
- Нагрузка должна автоматически балансироваться между всеми участниками кластера
- Должен иметь общее хранилище данных и автоматически распределять нагрузку по дискам
- Управлению виртуальной сетью должно осуществляться централизована в кластере


![gazprom-Page-4 drawio](https://user-images.githubusercontent.com/79700810/135603701-8bae9348-4f1c-4dcf-b6d9-abf292ffc81c.png)

## Базовая конфигурация
|ESXivCSA             |vCSA1             |ESXi1           |ESXi2           |
| ------------- | ------------- | ------------- |    ------------- | 
|ESXi 7.0.2 |vCenter Server 7.0.2   |ESXi 7.0.2|ESXi 7.0.2         |
|root |root   |root|root         |
|Pa$$w0rd |Pa$$w0rd  |Pa$$w0rd|Pa$$w0rd          |

## Основные службы 
- Active directory
- DNS
- vSphere Hypervisor
- vCenter server
- Distributed Switch 
- NFS
- VMware DRS

## Записи DNS на AD

Перед началам установки vCSA необходимо добавить записи типа А для хостов

```powershell
Add-DnsServerResourceRecordA -Name "esxivcsa1" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.4" -CreatePtr 

Add-DnsServerResourceRecordA -Name "vcsa1" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.5" -CreatePtr
```

Результат выполнения добавления записей DNS

![image](https://user-images.githubusercontent.com/79700810/135412898-0ae8a226-cd6a-4fc0-8d8f-fe5f27c9289f.png)

## Базовая настройка хоста ESXiVCSA1

На данный хост будет установлен vCSA для управления и конфигурации другими хостами ESXi
Для базовой настройки сети выбираем функцию F2 и вводи пароль
Переходим в управление менеджмент сетью

![image](https://user-images.githubusercontent.com/79700810/135403164-84049686-a6a1-422b-9b34-adedb037b642.png)

Задаем статические конфигурации сети 

![image](https://user-images.githubusercontent.com/79700810/135403249-bfc792ef-74dd-4851-9969-245f9c145769.png)

Переходим в DNS настройки и также задаем статические параметры 

![image](https://user-images.githubusercontent.com/79700810/135403300-f2039560-351d-4ff0-81dd-7fb362ec718c.png)

Нажимаем ESC 

![image](https://user-images.githubusercontent.com/79700810/135403423-606b27c7-eada-4179-a9e4-fd179dfa0d45.png)

после чего Y для сохранения конфигурации

![image](https://user-images.githubusercontent.com/79700810/135403468-cd30c045-466c-4223-a4b4-99e1a95e7c11.png)



## Установка vCSA с клиента DEV1

Перед началам установки зайти на https://esxivcsa1.ht2021.local

![image](https://user-images.githubusercontent.com/79700810/135850451-bfec721c-292c-4861-93f8-7d0373813209.png)

Перейти во вкладку storage далее в new datastore

![image](https://user-images.githubusercontent.com/79700810/135850561-72bfa540-cd88-4b86-8be4-1bda9412c090.png)

Создать новое хранилище куда будет установлен vCSA задаем имя и выбираем диск 

![image](https://user-images.githubusercontent.com/79700810/135850873-f2e1ff8b-8d07-4d17-9450-1220bf33dc73.png)


Монтируем диск стандартными средствами переходим в директорию и запускаем installer.exe

![image](https://user-images.githubusercontent.com/79700810/135404545-c901b91b-2212-4a1d-b06c-1fa552eed92b.png)

Выбираем install соглашаемся с лицензии
Далее указываем сервер ESXi на котором будет развернут vCSA (в случае возникновения ошибок по DNS имени можно использовать ip)

![image](https://user-images.githubusercontent.com/79700810/135404630-71ce1e7f-df5a-4b08-b459-ac3e1671c45c.png)

Указываем имя виртуальной машины vCSA и пароль от root

![image](https://user-images.githubusercontent.com/79700810/135404686-ae80a019-cd10-4523-a058-8708afbfcf1a.png)

Выбираем необходимый тир и место расположения (также ставим галку в чек-боксе “тонкий”)

![image](https://user-images.githubusercontent.com/79700810/135404742-d5798125-a7b8-4aeb-b0a6-ffbe87006b07.png)

Задаем статические конфигурации интерфейса для vCSA

![image](https://user-images.githubusercontent.com/79700810/135404962-025505a2-88df-4377-9e36-15aab143448d.png)


В ходе установки необходимо будет до конфигурировать сервер на втором этапе 

![image](https://user-images.githubusercontent.com/79700810/135412166-16ebc16e-a0b2-4944-ae92-0d307ecd7ae4.png)

Указываем сервер для синхронизации времени, которым выступает AD 

![image](https://user-images.githubusercontent.com/79700810/135412101-ca8c0ea6-a94f-4a48-865d-c86c4b16153c.png)

Указываем локальный префикс аунтификации vCSA и пароль учетной записи Administrator

![image](https://user-images.githubusercontent.com/79700810/135412335-a0e1a285-dd9d-4a45-8701-fdc6cb6b78ee.png)

Результат успешной установки и переходим по url адресу

![image](https://user-images.githubusercontent.com/79700810/135414383-b5d1b48c-e824-443a-a498-7fa76ec8b813.png)

Вводим учетную запись administrator@vsphere.local и пароль при установке на втором этапе

![image](https://user-images.githubusercontent.com/79700810/135414591-3fb60e05-bd09-4d39-baee-aa0850dd5932.png)

## Присоединение к контроллеру домена 

Переходим в menu далее в administration

![image](https://user-images.githubusercontent.com/79700810/135414702-873b227e-e2ca-4b7d-8fcf-b91ca597822c.png)

В разделе SSO переходим в разделе configuration выбираем AD и join AD 

![image](https://user-images.githubusercontent.com/79700810/135414774-9d158875-918c-48e7-a47e-8337ac243c45.png)

Указываем имя домена, OU и учетную запись администратора

![image](https://user-images.githubusercontent.com/79700810/135415042-cd48f4c9-cb0d-4ae7-bc20-6532a7ee8b0c.png)

Изменения вступят в силу после перезагрузки vCSA для этого заходи по адресу https://vcsa1.ht2021.local:5480

![image](https://user-images.githubusercontent.com/79700810/135415142-aea9af3f-526c-4056-a70d-e0a14d8ad472.png)

В верхней части выбираем Actions и reboot

![image](https://user-images.githubusercontent.com/79700810/135416603-83f0247a-5e4d-46aa-9af4-1de417cf4d21.png)

После перезагрузки переходим https://vcsa1.ht2021.local 

![image](https://user-images.githubusercontent.com/79700810/135416679-df40adf2-090e-4df7-a8a7-c471870b5917.png)

Добавление identyty для входа по суффиксу выбираем add

![image](https://user-images.githubusercontent.com/79700810/135416696-277ff07d-b2c0-4730-aa3a-3a6129630d06.png)

Указываем доменное имя и способ коннекта

![image](https://user-images.githubusercontent.com/79700810/135416779-513d68ec-e22d-4300-8af4-3c2696ad82a4.png)

Указываем доменное имя и способ коннекта

![image](https://user-images.githubusercontent.com/79700810/135416873-ee606086-dff7-4f8c-8206-60bf0e18a094.png)

Переходим в users and groups выбираем группу administrators и add members

![image](https://user-images.githubusercontent.com/79700810/135417144-e1c18168-8163-4639-86b2-541e3f0a3c4d.png)

Выбираем домен и группу пользователей 

![image](https://user-images.githubusercontent.com/79700810/135417075-890fb75f-d344-481d-afca-6fcf3e79cf07.png)

После чего можно аунтифицировать администратором домена на vCSA

![image](https://user-images.githubusercontent.com/79700810/135418208-fa92b8af-7630-4046-9dc0-5e8bb750860f.png)

## Базовая настройка хоста ESXi1

Перед началам настройки хостов ESXi необходимо добавить записи типа А 

```powershell
Add-DnsServerResourceRecordA -Name "esxi1" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.6" -CreatePtr

Add-DnsServerResourceRecordA -Name "esxi2" -ZoneName "ht2021.local" -AllowUpdateAny -IPv4Address "172.30.0.7" -CreatePtr
```

Для базовой настройки сети выбираем функцию F2 и вводи пароль
Переходим в управление менеджмент сетью
Задаем статические конфигурации сети 


![image](https://user-images.githubusercontent.com/79700810/135413309-84959e81-8e3e-4c13-87c5-759e8d7e27f6.png)

Переходим в DNS настройки и также задаем статические параметры 
Нажимаем ESC после чего Y для сохранения конфигурации

![image](https://user-images.githubusercontent.com/79700810/135414107-1c936869-0241-49aa-92a2-d34a484e6e48.png)


## Базовая настройка хоста ESXi2
Для базовой настройки сети выбираем функцию F2 и вводи пароль
Переходим в управление менеджмент сетью
Задаем статические конфигурации сети 

![image](https://user-images.githubusercontent.com/79700810/135414229-6f95de7c-153e-4053-a1e1-d872b878a2e2.png)

Переходим в DNS настройки и также задаем статические параметры 
Нажимаем ESC после чего Y для сохранения конфигурации

![image](https://user-images.githubusercontent.com/79700810/135414423-8a1ff8fd-413a-47d0-810b-d13a04da93ef.png)


## Создание дата центра

В vCSA выбираем правой кнопкой мыши new datacenter 

![image](https://user-images.githubusercontent.com/79700810/135418065-f2ed6bb9-b991-4f41-94b5-68ce66819e90.png)

Задаем имя 

![image](https://user-images.githubusercontent.com/79700810/135418349-564c76b0-86ed-4804-a63d-22687b68f943.png)

## Создание кластера 
В vCSA выбираем правой кнопкой мыши new Cluster
Задаем имя и параметры DRS и HA

![image](https://user-images.githubusercontent.com/79700810/135418408-b9fe568f-aca6-4161-8baf-9346e3caba1e.png)

В оснастке конфигурации кластера переходим в quick start и добавляем хосты

![image](https://user-images.githubusercontent.com/79700810/135418479-ab912d91-6484-4f11-b4f0-5c4c5090a7e5.png)

Указываем имена логин и пароль

![image](https://user-images.githubusercontent.com/79700810/135418557-6e576f50-c97d-4296-9a36-abd301c09a82.png)

Добавляем само подписанные сертификаты 

![image](https://user-images.githubusercontent.com/79700810/135418739-5239bafe-4eac-4a53-9ae6-836423b68696.png)

После создания кластера необходимо проинициализировать жесткие диски и создать хранилище

![image](https://user-images.githubusercontent.com/79700810/135418775-18cd39bd-1aec-4623-a40c-4d120c86c725.png)


## Инициализация дисков ESXi1

Переходим в хранение далее правой кнопкой мыши по дата центру и создать new Datastore

![image](https://user-images.githubusercontent.com/79700810/135424654-b13ce591-277f-4497-b5b7-506383f8ff88.png)

Выбираем тип VFMS для жесткого диска

![image](https://user-images.githubusercontent.com/79700810/135425020-48bee611-c3f8-4321-9465-6139ddf2f4e1.png)

Выбираем хост, на котором будем инициализировать диск и задаем имя

![image](https://user-images.githubusercontent.com/79700810/135425245-3673b0f8-9517-4d71-83cc-8ba99079b6c8.png)

Результат выбранных конфигураций 

![image](https://user-images.githubusercontent.com/79700810/135425308-e9f5cae8-5e18-49b9-93a8-b5053a74e116.png)

## Инициализация дисков ESXi2

По аналогии делаем тоже самое с вторым хостом выбираем диск и задаем имя

![image](https://user-images.githubusercontent.com/79700810/135425552-335f8a01-67db-4db6-b359-26c636d20cf0.png)

Результат выбранных конфигураций 

![image](https://user-images.githubusercontent.com/79700810/135425598-ca1e9de5-dd03-4599-ac46-70fa1652e556.png)


## Создание дата центра кластера хранилища

В результате есть два проинициализированных диска на хостах, которые можно объединить в управляемое централизованное хранилище для балансировки нагрузки

Переходим в хранение далее правой кнопкой мыши по дата центру и создать new Datastore cluster

![image](https://user-images.githubusercontent.com/79700810/135425651-8e1dff4a-cc65-4058-b78d-bf1a625cff8d.png)

Задаем имя и автоматическую работу DRS на кластере хранения

![image](https://user-images.githubusercontent.com/79700810/135424715-476f138e-9981-4ba2-b2af-34326947fe0f.png)

Выбираем кластер, в котором находиться хосты

![image](https://user-images.githubusercontent.com/79700810/135424825-963eaff1-0a83-4e81-b5cf-89e3a8f44e6d.png)

Далее отмечаем диски, которые войдут в состав кластера хранения

![image](https://user-images.githubusercontent.com/79700810/135425750-3da57df5-2b52-485b-8d49-b8414643c284.png)

## Подключение NFS для iso образов

Переходим в хранение далее правой кнопкой мыши по дата центру и создать new Datastore

![image](https://user-images.githubusercontent.com/79700810/135426724-0f5afb50-f444-471a-9cfc-ce66c03753f5.png)

Выбираем тип NFS

![image](https://user-images.githubusercontent.com/79700810/135426758-d968230c-b0c2-47a5-8015-4306c9b6ebf6.png)

Указываем имя, директорию и сервер (заранее сконфигурированных)

![image](https://user-images.githubusercontent.com/79700810/135426842-2ce8ce9a-4fa6-4b8a-ab5c-31efbad3fbac.png)

Указываем хосты, к которым будет монтироваться NFS

![image](https://user-images.githubusercontent.com/79700810/135426881-16d8e56c-1687-4f5f-9ece-2e2043dae7de.png)


## Конфигурация сети для кластера HA

В оснастке конфигурации кластера переходим в quick start и configure в 3 разделе 

![image](https://user-images.githubusercontent.com/79700810/136193163-4bf17432-21a8-47ca-a5de-34f85e32cac3.png)

Авто конфигуратор предложит создать Distributed switches и все необходимые портовые группы для работы кластера

![image](https://user-images.githubusercontent.com/79700810/135419126-ef91ef9f-eaad-47dd-9da7-876b25bf22b1.png)

Для vMouten сети будем использовать тот же сегмент где и менеджмент сеть 
Esxi1.ht2021.loacl адрес 172.30.0.10/24
Esxi2.ht2021.loacl адрес 172.30.0.11/24
Шлюз по умолчанию 172.30.0.254


![image](https://user-images.githubusercontent.com/79700810/136193266-3de24c2b-bb59-43a7-82bf-e4f46f2411af.png)

Указываем сервер времени AD

![image](https://user-images.githubusercontent.com/79700810/135419385-5fbedbdb-29f9-4181-90dd-f3b6bf355417.png)

## Создание дополнительной сети DMZ

Создать новый Distributed switch переходим в управление сетями далее в new Distributed switch

![image](https://user-images.githubusercontent.com/79700810/135446933-0c0d656b-12e0-4039-bb42-1647c4e69bd1.png)

Задаем имя 

![image](https://user-images.githubusercontent.com/79700810/135446954-4ae8563c-2d10-43e6-bd96-d4fbfdd940ea.png)

Задаем имя для портовой группы на Distributed switch 

![image](https://user-images.githubusercontent.com/79700810/135446997-b349f1bc-8387-48d7-849f-1521ecb1f66f.png)

Результат выбранных конфигураций

![image](https://user-images.githubusercontent.com/79700810/135447020-90f98242-ad1a-4e6f-9914-0a9c723f089b.png)

## Добавление DS на хосты 

На созданном DS выбираем add abd manage hosts

![image](https://user-images.githubusercontent.com/79700810/135447098-4e454a22-d3c2-4deb-ba3c-bc9c843c6b51.png)

Выбираем add hosts 

![image](https://user-images.githubusercontent.com/79700810/135447131-d96c126d-a01e-49b4-bfe7-135e60ec68a7.png)

Указываем хосты, на которые будет добавлен данный свич

![image](https://user-images.githubusercontent.com/79700810/135447182-91768211-ac7b-4b2f-b394-d0ff024bb110.png)

Выбираем второй интерфейс 

![image](https://user-images.githubusercontent.com/79700810/135447245-f7ad2161-61e0-4435-9fe9-c08ba13af5b6.png)

Указываем приходящий линк в свич

![image](https://user-images.githubusercontent.com/79700810/135447279-12310165-4c26-465c-a2a6-f7ca06063bf9.png)

Vmk и группа будут добелены позже

![image](https://user-images.githubusercontent.com/79700810/135447301-8516729a-d7c5-4247-827c-2e530a8df388.png)

## Добавление vmk и порт группы

Выбираем созданную порт группу далее add VMkernel adapter

![image](https://user-images.githubusercontent.com/79700810/135447370-29741047-3580-4196-87b5-e5eda2b0af30.png)

Добавляем хосты 

![image](https://user-images.githubusercontent.com/79700810/135447393-4dde2ee9-d651-459e-bab6-73ebbdbcb154.png)

Оставляем протокол IPv4

![image](https://user-images.githubusercontent.com/79700810/135447462-923aaf13-ce84-42f6-aa2c-845e395daa06.png)

Указываем статические настройки ip адресов и шлюза по умолчанию

![image](https://user-images.githubusercontent.com/79700810/135447630-379e8084-692f-46dc-81a4-da05a25399fa.png)

## Создание виртуальный машины

В кластере выбираем new VM

![image](https://user-images.githubusercontent.com/79700810/135428868-35fe3c27-fffd-4c80-a653-5f694a80be59.png)

Указываем что будет создана новая виртуальная машина 

![image](https://user-images.githubusercontent.com/79700810/135428905-f1024ced-2c62-4e00-991d-d32c48b23448.png)

Задаем имя 

![image](https://user-images.githubusercontent.com/79700810/135429197-708494d4-9eaa-4b27-9ef1-003b91b7e327.png)

Выбираем место расположения для хранения 

![image](https://user-images.githubusercontent.com/79700810/135429303-c53136ff-8711-4ca5-a1a5-a20aa454f6a8.png)

Указываем семейство и версию ОС

![image](https://user-images.githubusercontent.com/79700810/135429405-4c8b6bf4-413b-4b05-9deb-002951323123.png)

Для экономии места на жестком диске выбираем Thin provision 

![image](https://user-images.githubusercontent.com/79700810/135429593-a1e5b1af-5b34-433d-b81f-51a4acd0a5eb.png)

Выбираем сеть VM network (стандартная сеть созданная DS) и выбираем CD\DVD Datastore iso file

![image](https://user-images.githubusercontent.com/79700810/135429674-8d36f7ac-ae09-49d3-853d-f10a2c03e7e8.png)

C NFS выбираем необходимый iso и указываем в поле connect 

![image](https://user-images.githubusercontent.com/79700810/135429749-d7241b86-ecab-416e-bb98-cc5e96723050.png)

Запускаем созданную виртуальную машину

![image](https://user-images.githubusercontent.com/79700810/135429857-abb21abc-ffe9-4728-a70d-fd16969c99d4.png)

## Установка ОС

Необходимые пакеты guest agents и standard

![image](https://user-images.githubusercontent.com/79700810/135430573-9b52ed0a-d064-465c-a147-5c68a1ac293e.png)

Задаем пароль для root и user

![image](https://user-images.githubusercontent.com/79700810/135430773-d2584e3d-0dbf-49bb-a2ca-5b74504e08fc.png)

После установки перезагружаем для завершения процесса установки

![image](https://user-images.githubusercontent.com/79700810/135435183-7fc74a54-e07a-4fae-81aa-6bcbbc727bbd.png)

## Создание Шаблона

Выбираем виртуальную машину, которую хотим конвертировать в шаблон (должна быть выключена)

![image](https://user-images.githubusercontent.com/79700810/135445732-c6a79957-bf19-43dd-a251-5db26190c6ee.png)

Применяем конвертацию

![image](https://user-images.githubusercontent.com/79700810/135445763-f7715c40-59d5-4e56-9c99-5a5212b291da.png)

