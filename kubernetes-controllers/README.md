# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №1

 - [x] Основное ДЗ
 - [x] Задание со *

## В процессе сделано:

 - ###### Создан корректный манифетс ReplicaSet:

    Необходимо добавть к шаблону из презентации дополнительное определение Selector'а
    ```yaml
    selector:
        matchLabels:
        app: frontend
    ```

 - ###### Разобран механизм работы ReplicaSet по обновлению и перезапуску pod'ов:

    Как следует из описания [ReplicaSet](Разобрать механизм работы ReplicaSet по обновлению и перезапуску pod'ов), этот контроллер проверяет количество запущенных Pod'ов с соотвествующим selector'ом и создает новые из шаблона Pod'а данного ReplicaSet контроллера.
    Он не проверят соответствие шаблона запущенных Pod'ов и шаблонов хранящихся в etcd.

 - ###### Создан манифест Deployment для создания трех pod'ов.

 - ###### :star: Созданы два манифеста для Blue-Green и Revers стратегии развертывания
    [Blue-green strategy](https://www.redhat.com/en/topics/devops/what-is-blue-green-deployment)

    >Сначала выкатить весь новый сервис и дождатьс его готовности, а потому удалить старую версию сервиса.

    Допонительные настройки стратегии для Deployment'а
    ```yaml
    strategy:
        type: RollingUpdate
        rollingUpdate:
        maxSurge: 100%
        maxUnavailable: 0
    ```

    Reverse Rolling Update

    >Удалить старый под, создать новый, дождаться запуска, удалить старый, добавить новый.
    >(Стандартно сначала создается новый и дожидается запуска, а потом удалется старый)

    Допонительные настройки стратегии для Deployment'а
    ```yaml
    strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    ```
 - ###### Добавить readinessProbe к манифесту Deployment
    Описание [readinessProbe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-readiness-probes)

    ```yaml
    readinessProbe:
    initialDelaySeconds: 10
    httpGet:
        path: "/_healthz"
        port: 8080
        httpHeaders:
        - name: "Cookie"
        value: "shop_session-id=x-readiness-probe"
    ```
 - ##### :star: Написать манифест DaemonSet для node-exporter

    Возьмем описание [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) контроллера.
    Используем описание [node-exporter](https://github.com/prometheus/node_exporter) - заметим что чтобы использовать его на ноде и видеть пространство имен всего хоста, нам необходимо это явно указать при запуске контейнеров.
    ```yaml
    ...
    ### Указание на использования pid и network ns хоста
    hostNetwork: true
    hostPID: true
    ...
    ### Дополнительные точки монтирования
    volumeMounts:
    - mountPath: /host/proc
        name: proc
        readOnly: true
    - mountPath: /host/sys
        name: sys
        readOnly: true
    - mountPath: /host
        name: host
        readOnly: true
    ...
    ### Сами Volume
    volumes:
    - hostPath:
        path: /proc
    name: proc
    - hostPath:
        path: /sys
    name: sys
    - hostPath:
        path: /
    name: host
    ...
    ```

 - ###### :star: Дописать tolerans для DaemonSet'a
    Добавим [toleration](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#concepts) к любым [taint](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#concepts)
    ```yaml
    tolerations:
    - operator: Exists
    ```


## Как запустить проект:
 - Запустить команду (напримере kind)
 ```shell
git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
cd xom4ek_platform && \
git checkout kubernetes-controllers && \
cat << EOF > cluster.kind.config
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
EOF
kind create cluster --config cluster.kind.config && \
kubectl create -f kubernetes-controllers/frontend-deployment.yaml && \
kubectl create -f kubernetes-controllers/paymentservice-deployment.yaml && \
kubectl create -f kubernetes-controllers/node-exporter-daemonset.yaml
 ```

## Как проверить работоспособность:

- Выполнить команды:
```shell
kubectl get pods --field-selector=status.phase=Running
```

- :star: Выполнить команду:

```shell
### blue-green check
kubectl apply -f kubernetes-controllers/paymentservice-deployment-bg.yaml && \
kubectl set image deployment paymentservice paymentservice=xom4ek/microservices-demo-paymentservice:v0.0.2 && \
kubectl get pods -l app=paymentservice --watch

### revers check
kubectl apply -f kubernetes-controllers/paymentservice-deployment-revers.yaml && \
kubectl set image deployment paymentservice paymentservice=xom4ek/microservices-demo-paymentservice:v0.0.2 && \
kubectl get pods -l app=paymentservice --watch

### node-exporter check
kubectl port-forward --address 0.0.0.0 $(kubectl get pods -l app=node-exporter -o jsonpath='{.items[0].metadata.name}') 9100:9100 &
curl http://127.0.0.1:9100/metrics
```

## PR checklist:
- [x] Выставлен label с темой домашнего задания
