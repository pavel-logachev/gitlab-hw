# Домашнее задание к занятию «GitLab»

Выполнил: Павел Логачев

## Стенд

GitLab CE и GitLab Runner развёрнуты локально в Docker Compose. Официальное задание предлагает Vagrant, но на рабочей станции нет Vagrant/VirtualBox, поэтому использована эквивалентная изолированная схема на официальных Docker-образах:

- GitLab CE: `http://localhost:8091`;
- GitLab Runner с Docker executor;
- отдельная сеть `gitlab-lab` для GitLab, runner и CI job;
- локальные пароли и токены находятся только вне Git в `.env` и Docker volume;
- проект в локальном GitLab: `root/gitlab-ci-homework`.

Инфраструктура описана в [infra/compose.yaml](infra/compose.yaml).

## Задание 1. GitLab и runner

Создан пустой проект `gitlab-ci-homework`. Через современный `POST /user/runners` создан project runner `netology-docker-runner`, после чего GitLab Runner зарегистрирован с Docker executor.

Фактическая конфигурация runner:

- executor: `docker`;
- default image: `alpine:3.22`;
- tag: `docker`;
- privileged mode включён только для локальной учебной сборки Docker-in-Docker;
- токен runner не публикуется.

Скриншот настроек runner будет добавлен после запуска стенда.

## Задание 2. Pipeline

В [.gitlab-ci.yml](.gitlab-ci.yml) определены стадии `test` и `build`:

- `unit-tests` запускает `go test ./...` в официальном Go-образе;
- `container-build` запускает Docker-in-Docker, собирает образ и проверяет его через `docker image inspect`.

Скриншот успешного pipeline будет добавлен после запуска стенда.

## Дополнительное задание

Выполнены оба условия:

- сборка имеет `needs: []`, поэтому не ждёт тесты;
- тесты запускаются только при изменении `*.go` или `go.mod`.

## Локальная проверка

```bash
go test ./...
docker build -t gitlab-ci-homework:local .
docker run --rm gitlab-ci-homework:local Netology
```

Ожидаемый вывод контейнера: `Hello Netology!`.

Netology GitLab CI homework with local runner
