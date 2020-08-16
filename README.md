# xom4ek_platform

xom4ek Platform repository

## Краткое описание

Пытаемся разобраться в работе k8s используя [Demo](https://github.com/GoogleCloudPlatform/microservices-demo)

### 7. Kubernetes-operators

#### Задания:
- Создать cr для mysql
- Отредактировать crd добавив requirements
- Проверить работу backup job

#### Полезные ссылки

- [cr](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
- [Описание выполненного ДЗ](kubernetes-operators/README.md)

### 1. Kubernetes-intro

#### Задания:

- Разобрать механизм запуска подов в namespace kube-system при использовании kubeadm
- Написать Dockerfile и собрать image с вебсервером
- Написать манифест для запуска контейнера в Pod'e
- :star: Изменить манифест для перевода Pod'a в статус Ready

#### Полезные ссылки

- [StaticPods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/)
- [Pods Overview](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/)
- [Dockerfile](https://docs.docker.com/engine/reference/builder/)
- [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- [Описание выполненного ДЗ](kubernetes-intro/README.md)

### 2. Kubernetes-controllers

#### Задания:
- Создать корректный манифест ReplicaSet для создания трех pod'ов
- Разобрать механизм работы ReplicaSet по обновлению и перезапуску pod'ов
- Создать манифест Deployment для создания трех pod'ов
- :star: Создать два манифеста для Blue-Green и Revers стратегии развертывания
- Добавить readinessProbe к манифесту Deployment
- :star: Написать манифест DaemonSet для node-exporter
- :star: Дописать tolerans для DaemonSet'a

#### Полезные ссылки

- [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
- [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Deployment Update Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)
- [Blue-green strategy](https://www.redhat.com/en/topics/devops/what-is-blue-green-deployment)
- [ReadinessProbe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-readiness-probes)
- [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
- [Node-exporter](https://github.com/prometheus/node_exporter)
- [Taints and Toleration](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#concepts)
- [Описание выполненного ДЗ](kubernetes-controllers/README.md)

### 3. Kubernetes-security

#### Задания:

##### task01
- Создать Service Account bob, дать ему роль admin в рамках всего кластера
- Создать Service Account dave без доступа к кластеру

###### taks02
- Создать Namespace prometheus
- Создать Service Account carol в этом Namespace
- Дать всем Service Account в Namespace prometheus возможность делать get, list, watch в отношении Pods всего кластера

###### task03
- Создать Namespace dev
- Создать Service Account jane в Namespace dev
- Дать jane роль admin в рамках Namespace dev
- Создать Service Account ken в Namespace dev
- Дать ken роль view в рамках Namespace dev

#### Полезные ссылки

- [ServiceAccountsForPods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [kubectl auth can-i](https://kubernetes.io/docs/reference/access-authn-authz/authorization/)
- [Описание выполненного ДЗ](kubernetes-security/README.md)

### 4. Kubernetes-networks

#### Задания:
- Добавлены и изучены механизмы liveness и readiness probe
- Добавлены и изучены механизмы liveness и readiness probe
- Создали несколько типов services
- Установлен MetalLB / Ingress / законфигурирован minikube длля использования IPVS
- :star: Сделан сервис LoadBalancer , который откроет доступ к CoreDNS снаружи кластера
- Создан service с внешним IP выданным MetalLB для использования под ingress + headless services
- :star: Создан ingress для kubernetes dashobard для доступа за /dashbaord
- :star: Создан ingress с конфигурацией под канареечное развертывание

#### Полезные ссылки
- [svc and iptables](https://msazure.club/kubernetes-services-and-iptables/)
- [ipvs k8s](https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/ipvs/README.md)
- [strictARP issue](https://github.com/metallb/metallb/issues/153)
- [Balancing types](https://github.com/kubernetes/kubernetes/blob/1cb3b5807ec37490b4582f22d991c043cc468195/pkg/proxy/apis/config/types.go) и [another](http://www.linuxvirtualserver.org/docs/scheduling.html)
- [Metallb](https://metallb.universe.tf/)
- [Ingress-nginx](https://kubernetes.github.io/ingress-nginx/deploy/)
- [Описание выполненного ДЗ](kubernetes-networks/README.md)

### 5. Kubernetes-volumes

#### Задания:
- Запусить statefulset c Minio
- Запусить headless service c Minio
- :star: Перенести ключи minio в secrets

#### Полезные ссылки

- [mc](https://github.com/minio/mc) or [here](https://docs.min.io/docs/minio-client-complete-guide.html)
- [Описание выполненного ДЗ](kubernetes-volumes/README.md)

### 6. Kubernetes-templating

#### Задания:
- Установить harbor
- Установить nginx-ingress
- Установить cert-manager
- Установить chartmuseum
- Создать свой chart
- Использовать jsonnet
- Использовать kustomize

#### Полезные ссылки

- [cert-manager](https://cert-manager.io)
- [helm](https://helm.sh)
- [Описание выполненного ДЗ](kubernetes-templating/README.md)
