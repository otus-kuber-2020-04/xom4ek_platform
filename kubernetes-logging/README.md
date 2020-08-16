# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №6

 - [x] Основное ДЗ

## В процессе сделано:

- Установить EFK stack
- Создать dashboard в kibana
- Установить Loki
- Создать dashboard в grafana

## Как запустить проект:
 - Запустить команду
 ```shell
 kubectl create ns microservices-demo && \
 kubectl apply -f https://raw.githubusercontent.com/express42/otus-platformsnippets/master/Module-02/Logging/microservices-demo-without-resources.yaml -n microservices-demo && \
 kubectl create ns observability && \
 helm upgrade --install elasticsearch elastic/elasticsearch --namespace observability -f kubernetes-logging/elasticsearch.values.yaml && \
 helm upgrade --install kibana elastic/kibana --namespace observability -f kubernetes-logging/kibana.values.yaml && \
 helm upgrade --install fluent-bit stable/fluent-bit --namespace observability -f kubernetes-logging/fluent-bit.values.yaml && \
 kubectl create ns nginx-ingress && \
 helm upgrade --install nginx-ingress stable/nginx-ingress --wait --namespace=nginx-ingress -f ingress.values.yaml && \
 helm upgrade --install loki loki/loki-stack --namespace observability -f loki.values.yaml
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  http://kibana.34.77.171.250.nip.io/
  http://prometheus.34.77.171.250.nip.io/
  http://grafana.34.77.171.250.nip.io/
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
