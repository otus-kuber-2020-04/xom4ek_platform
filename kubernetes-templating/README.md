# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №6

 - [x] Основное ДЗ

## В процессе сделано:

###### taks01
- Установлен chartmuseum
- Установлен cert-manager
- Установлен nginx-ingress

###### task02
- Установлен harbor

###### task03
- Cоздан helm chart для hipster-shop
- Cоздан chart для frontend

## Как запустить проект:
 - Запустить команду
 ```shell
 git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
 cd xom4ek_platform && \
 git checkout kubernetes-templating && \
 kubectl create ns chartmuseum &&
 helm upgrade --install chartmuseum stable/chartmuseum -n chartmuseum -f kubernetes-templating/chartmuseum/values.yaml &&
 kubectl create ns cert-manager &&
 helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v0.16.1 --set installCRDs=true &&
 kubectl create ns nginx-ingress &&
 helm upgrade --install nginx-ingress stable/nginx-ingress -n nginx-ingress &&
 kubectl create ns hipster-shop && helm upgrade --install hipster-shop kubernetes-templating/hipster-shop -n hipster-shop &&
 kubectl apply -k kubernetes-templating/kustomize/overrides/hipster-shop-prod
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  # task01
  curl https://chartmuseum.34.77.171.250.nip.io
  # task02
  curl https://harbor.34.77.171.250.nip.io
  # task03
  curl https://hipster-shop.34.77.171.250.nip.io
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
