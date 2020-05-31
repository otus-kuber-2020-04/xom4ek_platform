# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №1

 - [x] Основное ДЗ
 - [x] Задание со *

## В процессе сделано:

 - Настроено локальное окружение

 - Разобран механизм перезапуска Podов:
> minikube для запуска Pod\`ов:
-- kube-scheduler-minikube
-- kube-apiserver-minikube
-- kube-controller-manager-minikube
-- etcd-minikube
 Использует механизм [static pods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/), так как внутри VM использует kubeadm, однако это далеко не всегда static pod\`ы, да и не всегда вообще Pod\`ы.
Например rke запускает эти модули k8s [средствами docker\`а ](https://docs.docker.com/config/containers/start-containers-automatically/) в контейнерах.
>
> --  coredns
Запускается средставим k8s используя контроллер [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
>
> -- kube-proxy
Запускается средставим k8s используя контроллер [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
>

 - Написан Dockerfile и собран контейнер с веб серевером

 - Написан манифест для запуска контейнера в Pod`e с init контейнером

 - :star: Дополнен манифест для перевода Pod`a в фазу Ready

## Как запустить проект:
 - Запустить команду
 ```shell
 git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
 cd xom4ek_platform && \
 git checkout kubernetes-intro && \
 kubectl create -f kubernetes-intro/web-pod.yaml && \
 kubectl create -f kubernetes-intro/frontend-pod-healthy.yaml
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  kubectl port-forward --address 0.0.0.0 pod/web 8000:8000 &
  curl http://127.0.0.1:8000
  ```

 - :star: Выполнить команду:
 ```shell
 kubectl get pods -l run=frontend --field-selector=status.phase=Running
 ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
