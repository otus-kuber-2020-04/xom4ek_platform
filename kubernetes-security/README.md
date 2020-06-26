# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №1

 - [x] Основное ДЗ

## В процессе сделано:

##### task01
- Cоздан Service Account bob, Выдана ему роль admin в рамках всего кластера
- Cоздан Service Account dave без доступа к кластеру

###### taks02
- Cоздан Namespace prometheus
- Cоздан Service Account carol в этом Namespace
- Выдана всем Service Account в Namespace prometheus возможность делать get, list, watch в отношении Pods всего кластера

###### task03
- Cоздан Namespace dev
- Cоздан Service Account jane в Namespace dev
- Выдана jane роль admin в рамках Namespace dev
- Cоздан Service Account ken в Namespace dev
- Выдана ken роль view в рамках Namespace dev

## Как запустить проект:
 - Запустить команду
 ```shell
 git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
 cd xom4ek_platform && \
 git checkout kubernetes-security && \
 kubectl create -f kubernetes-security/task01/task.yaml && \
 kubectl create -f kubernetes-security/task02/task.yaml && \
 kubectl create -f kubernetes-security/task03/task.yaml && \
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  # task01
  kubectl auth can-i --list --namespace=kube-system --as=system:serviceaccount:default:dave
  kubectl auth can-i --list --namespace=default --as=system:serviceaccount:default:dave
  # task02
  kubectl auth can-i --list --namespace=prometheus --as=system:serviceaccount:prometheus:carol
  # task03
  kubectl auth can-i --list --namespace=dev --as=system:serviceaccount:dev:jane
  kubectl auth can-i --list --namespace=dev --as=system:serviceaccount:dev:ken
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
