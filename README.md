# xom4ek_platform
xom4ek Platform repository

## Краткое описание

Пытаемся разобраться в работе k8s используя [Demo](https://github.com/GoogleCloudPlatform/microservices-demo)

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