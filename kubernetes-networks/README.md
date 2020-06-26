# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №1

- [x] Основное ДЗ
- [x] Задание со *

## В процессе сделано:

- #### Добавлены и изучены механизмы liveness и readiness probe

 Дополнительно они описанны по [ссылке](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

  ```yaml
  readinessProbe:
    httpGet:
      path: /index.html
      port: 8000
  livenessProbe:
    tcpSocket:
      port: 8000
  ```

- #### Создали несколько [типов services](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)

  - [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer)
  - [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport)
  - [ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
  - [ExternalName](https://kubernetes.io/docs/concepts/services-networking/service/#externalname)

  Дополнительно про endpoints можно почитать [тут](https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/)

- #### Установлен MetalLB / Ingress / законфигурирован minikube длля использования IPVS
  - Настройка использования [IPVS]()
  ```sh

  ### move strictARP to true and mode to IPVS
  kubectl get configmap kube-proxy -n kube-system -o yaml | \
  sed -e 's/strictARP: false/strictARP: true/' | \
  sed -e 's/mode: ""/mode: "ipvs"/' | \
  kubectl apply -f - -n kube-system

  ### recreate pods kube-proxy
  kubectl --namespace kube-system delete pod --selector='k8s-app=kube-proxy'
  ```

  - Установка [MetalLB](https://metallb.universe.tf/installation/)
  ```sh
  export VERSION_MLB=v0.9.3
  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION_MLB/manifests/namespace.yaml
  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION_MLB/manifests/metallb.yaml
  # On first install only
  kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
  ```
  - Установка [Nginx-ingress](https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal)
  ```sh
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
  ```

- #### :star: Сделан сервис LoadBalancer , который откроет доступ к CoreDNS снаружи кластера

    Использование разных протоколов в одном service с типом [LoadBalancing запрещено](https://github.com/kubernetes/kubernetes/issues/23880) пока не реализовано, поэтому не получится использовать один service.
    Необходимо использовать annotation MetalLB [metallb.universe.tf/allow-shared-ip](https://metallb.universe.tf/usage/#ip-address-sharing), что позволит двум Service с разными протоколами маршрутизироваться по одному внешнему IP.

- #### Создан service с внешним IP выданным MetalLB для использования под ingress +  headless сервис

  Service для Ingress
  ```yaml
  spec:
    externalTrafficPolicy: Local
    type: LoadBalancer
    selector:
      app.kubernetes.io/name: ingress-nginx
  ```

  Headless
  ```yaml
  type: ClusterIP
  clusterIP: None
  ```

  Ну и пример правила для ingress

  ```yaml
  spec:
    rules:
    - http:
        paths:
        - path: /web
          backend:
            serviceName: web-svc
            servicePort: 8000
  ```

  Дополнительно про spec можно почитать [тут](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/)

- #### :star: Создан ingress для kubernetes dashobard для доступа за /dashbaord

    Были использованы стандартные [аннотации nginx-ingress](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/):
    - [nginx.ingress.kubernetes.io/rewrite-target](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rewrite)
    - [nginx.ingress.kubernetes.io/backend-protocol](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#backend-protocol)
    - [nginx.ingress.kubernetes.io/permanent-redirect](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#permanent-redirect)

  Важный кусок
  ```yaml
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
  ...
  - path: /dashboard/(.*)
  ```

  B для того чтобы работало dashboard без /
  ```yaml
  annotations:
    nginx.ingress.kubernetes.io/permanent-redirect: /dashboard/
  ...
  - path: /dashboard$
  ```

- #### :star: Создан ingress с конфигурацией под канареечное развертывание
  Общее описание Canary для ingress-nginx [тут](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#canary)
  Использовались anotations:
  - nginx.ingress.kubernetes.io/canary
  - nginx.ingress.kubernetes.io/canary-by-header
  - nginx.ingress.kubernetes.io/canary-by-header-value

  > Без конкретного hostname в ingress ничего не работало, хочется понять почему.

## Как запустить проект:
 ```shell
git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
cd xom4ek_platform && \
git checkout kubernetes-networks && \
cd kubernetes-networks && prepare/install.sh
 ```

## Как проверить работоспособность:

- :star: coredns:

```shell
nslookup kubernetes.default.svc.cluster.local 172.17.255.10
```

- :star: ingress for Dashboard:

```shell
curl -L $(kubectl get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')/dashboard
```

- :star: canary ingress

```shell

curl -s --resolve example.com:80:kubectl get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}' example.com:80/canary | grep -v '>'

curl -s --resolve example.com:80:kubectl get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}' -H "canary:catch" example.com:80/canary | grep -v '>'
```

## PR checklist:
- [x] Выставлен label с темой домашнего задания
