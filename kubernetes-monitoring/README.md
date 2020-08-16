# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №7

 - [x] Основное ДЗ

## В процессе сделано:

#### Задания:

- #### Установить prometheus-operator
```sh
kubectl create ns prometheus && \
helm upgrade --install prometheus stable/prometheus-operator -n prometheus --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false
```

- #### Запустить nginx с nginx-exporter
```sh
kubectl apply -f kubernetes-monitoring/nginx.yaml
```

## Как запустить проект:
 - Запустить команду
 ```shell
  kubectl create ns prometheus && \
  helm upgrade --install prometheus stable/prometheus-operator -n prometheus \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false &&
  kubectl apply -f kubernetes-monitoring/nginx.yaml
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  kubectl -n prometheus port-forward --address 0.0.0.0 pod/prometheus-prometheus-prometheus-oper-prometheus-0 9090:9090
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
