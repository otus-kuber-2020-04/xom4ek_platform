# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №1

 - [x] Основное ДЗ

- Проверить работу backup job
##### task01
- Создан CR для mysql
- Добавлены requirements в crd
- Проверена работа backup jobs

## Как запустить проект:
 - Запустить команду
 ```shell
 kubectl apply -f kubernetes-operators/deploy
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  >export MYSQLPOD=$(kubectl get pods -l app=mysql-instance -o jsonpath="
  {.items[*].metadata.name}")
  >kubectl exec -it $MYSQLPOD -- mysql -potuspassword -e "select * from test;" otus-database

  mysql: [Warning] Using a password on the command line interface can be insecure.
  +----+-------------+
  | id | name        |
  +----+-------------+
  |  1 | some data   |
  |  2 | some data-2 |
  +----+-------------+
  >k get jobs -A
  NAMESPACE   NAME                         COMPLETIONS   DURATION   AGE
  default     backup-mysql-instance-job    1/1           2s         5m9s
  default     restore-mysql-instance-job   1/1           3m34s      7m13s
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
