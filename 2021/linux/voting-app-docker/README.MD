# Docker commands

## Отключить SELinux

```bash
setenforce 0
vim /etc/selinux/config
```
```
SELINUX=permissive
```

## Отключить firewalld

```
systemctl stop firewalld.service
systemctl disable firewalld.service
```

## Установка docker в CentOS 8

[Docker installation](https://docs.docker.com/engine/install/centos/)

```bash
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
```

Запускаем и добавляем в автозагрузку

```bash
systemctl start docker.service
systemctl enable docker.service
```

## Скачиваем исходники приложения

```bash
dnf install -y git
git clone https://github.com/dockersamples/example-voting-app
```

Создаем директорию в которой будем работать

```bash
mkdir vote-app
cp -rv example-voting-app/vote vote-app/vote
cp -rv example-voting-app/worker vote-app/worker
cp -rv example-voting-app/result vote-app/result
cd vote-app
```

## Networks

Создаём network для postgres, redis и worker

```bash
docker network create -d bridge backend
docker network ls
```

## Redis

Запускаем redis в docker

```bash
mkdir -p /opt/redis/data
docker run -d \
           --name redis \
           --restart always \
           --network backend \
           -v /opt/redis/data:/data \
       redis
docker ps
```

## Postgres

Запускаем psotgres в docker

```bash
mkdir -p /opt/pgdata
docker run -d --name db \
           -e POSTGRES_USER=postgres \
           -e POSTGRES_PASSWORD=postgres \
           --restart always \
           -v /opt/pgdata:/var/lib/postgresql/data \
           --network backend \
           postgres
docker ps
```

## Vote service

Собираем image для voteing service и запускаем в docker

```bash
docker build ./vote -t vote
docker images
docker run -d --name vote \
        --restart always \
        --network backend \
        -p 3000:80 \
        vote
docker ps
```

## Worker service

Собираем image для worker service и запускаем в docker

```bash
docker build ./worker -t worker
docker images
docker run -d --name worker \
        --restart always \
        --network backend \
        worker
docker ps
docker logs worker
```

## Result service

Собираем image для result service и запускаем в docker

```bash
docker build ./result -t result
docker images
docker run -d --name result \
        --restart always \
        --network backend \
        -p 4000:80 \
        result
docker ps
```

# Docker compose

```bash
docker stop $(docker ps --format='{{.ID}}')
docker ps -a
docker rm $(docker ps -a --format='{{.ID}}')
docker ps -a
```

[Docker compose installation](https://docs.docker.com/compose/install/)

```bash
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

```bash
vim docker-compose.yml
```

```YAML
version: '3.4'

services:
  vote:
    image: vote
    build: ./vote
    depends_on:
      - redis
    ports:
      - '3000:80'
    networks:
      - backend
  redis:
    image: redis
    volumes:
      - redis:/data
    networks:
      - backend
  db:
    image: postgres
    environment:
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: 'postgres'
    volumes:
      - pgdata:/var/lib/postgresql/data
    networks:
      - backend
  worker:
    image: worker
    build: ./worker
    depends_on:
      - redis
      - db
    networks:
      - backend
  result:
    image: result
    build: ./result
    ports:
      - '4000:80'
    networks:
      - backend

volumes:
  redis:
  pgdata:

networks:
  backend:
```

```bash
docker-compose up
```