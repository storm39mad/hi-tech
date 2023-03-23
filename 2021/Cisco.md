СТАТИЧЕСКИЕ МАРШРУТЫ

S AD = 1 

EN
CONF T
A)IP ROUTE СЕТЬ НАЗНАЧЕНИЯ IP СОСЕДНЕГО 
УСТРОЙСТВА
Б)IP ROUTE СЕТЬ НАЗНАЧЕНИЯ ИСХОДЯЩИЙ ИНТЕРФЕЙС

1. МАРШРУТ ПО УМОЛЧАНИЮ
IP ROUTE 0.0.0.0 0.0.0.0 ИСХОДЯЩИЙ ИНТЕРФЕЙС

2. ПЛАВАЮЩИЙ МАРШРУТ
IP ROUTE 0.0.0.0 0.0.0.0 ИСХОДЯЩИЙ ИНТЕРФЕЙС ЧИСЛО

BGP

en
conf t
router bgp 65000
network 192.168.1.0 mask 255.255.255.0
neighbor 10.10.10.1 remote-as 65001



Route-map

состоит из правил:
каждое из правил, указывает отправлять указанные пакеты по правилам или нет
permit значит, что пакеты, которые попадают в описание match, буду отправлены так как описано в set
deny значит, что пакеты будут отправлены на стандартную маршрутизацию
В каждом правиле route-map два компонента:
match - описывает какой трафик должен маршрутизироваться согласно PBR
как правило, для PBR, используется в виде match ip address <acl>
set - описывает куда перенаправлять трафик, который описан в match
как правило, и	спользуется в виде set ip next-hop <ip-address>
У каждого правила route-map есть порядковый номер
когда пакеты проходят сквозь интерфейс, к которому применена PBR, пакеты проверяются по порядку по правилам
если пакет совпал с описанием в match, то он маршрутизируется по правилу set
если пакет не совпал с описанием в match, правила проверяются дальше
если ни в одном правиле совпадения не найдено, то пакет будет маршрутизироваться по стандартной таблице маршрутизации

route-map TEST permit 10
 match ip address VLAN_10
 set ip next-hop 10.0.1.1
route-map PBR permit 20
 match ip address VLAN_20
 set ip next-hop 10.0.2.2

interface Gi0/0
 ip policy route-map TEST

МАРШРУТ ПО УМОЛЧАНИЮ
neighbor <address>  default-originate [route-map <map-name>]


стандартные
расширенные

нумерованные ACL 
именованные ACL

enable
conf t
access-list 1-99(стандартные) permit/deny описание какой-то сети или устройства

255.255.255.255
255.255.255.0
 access-list 5 permit 192.168.1.0 0.0.0.255

host - 1 устройство
any - все устройства

access-list 5 deny any

1. То, что не разрешено, то запрещено
2. Все команды выполняются по очереди сверху вниз

Если есть необх запретить доступ 1 узлу в сети,
то сначала запрещаем , а потом разрешаем остальное

permit host ...
deny any

применение:

a) интерфейс
б) удал. доступ
в) на дополнит службы ( NAT, Ipsec и т.д.)

a) interface ...
ip access-group #списка in/out

б)line vty 0 4
access-class #списка in/out

ssh 
Router(config)#hostname R1
R1(config)#ip domain-name cisco.com
R1(config)#username admin priv 15 secret cisco
R1(config)#crypto key generate rsa 
1024
R1(config)#ip ssh version 2
R1(config)#line vty 0 4
R1(config-line)#transport input ssh 
R1(config-line)#login local

Стандартные списки располагают как можно ближе к точке 
регулирования

Стандартные именованные списки

en
conf t
ip access-list standart имя
permit ... - 10
deny...    - 20

no 10 -удалить 1 строку
15 permit ...

Расшир. списки

access-list 100-199 permit/deny протокол исходящяя сеть сеть назначения [номер порта]

access-list 105 permit 192.168.1.0 0.0.0. 255 192.168.2.0 0.0.0.255 eq 80

eq =
lt <
gt >

Расшир. именованные списки

ip access-list extended имя 
permit ...
deny ...

NAT

1.  Написать access-list описывающий трафик который мы будем фильтровать (в основном входящий трафик)
2. на внутр. интерфейсе - ip nat inside
3. на внешн. интерфейсе - ip nat outside

en
conf t
ip nat inside source list #списка interface внешний интерфейс overload  - pat
show ip nat translations - показать преобразования

VRRP

int ...
vrrp номер группы ip ....
vrrp 1 ip 192.168.1.1
vrrp priority число

Active - работает
Listening - на готове

preemt 

int 
no vrrp 1 preempt

hsrp

int ...
standby 1 ip 192.168.1.1
stadby priority ...
standby preemt - вкл preemt



SYSLOG

logging trap уровень "ловушек"
logging host ip add
R1(config)#service timestamps log datetime msec 

SNMP

AAA

authentication user? login/pass?
authorization  права?
accounting учет деятельности пользователя

1. local
2. RADIUS
3. TACACS

aaa new-model

(c) aaa authentication login CISCO local 
или 
aaa authentication login CISCO group radius/tacacs

(c) aaa authorization exec CISCO2 local 
или 
aaa authorization  login CISCO2 group radius/tacacs





                             





