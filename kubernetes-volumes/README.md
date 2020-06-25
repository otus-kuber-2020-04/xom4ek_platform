# xom4ek_platform
xom4ek Platform repository

# Выполнено ДЗ №5

 - [x] Основное ДЗ
 - [x] Задание со *

## В процессе сделано:

#### Задания:
- #### Запусить statefulset c Minio
```sh
kubectl apply -f https://raw.githubusercontent.com/express42/otus-platform- snippets/master/Module-02/Kuberenetes-volumes/minio-statefulset.yaml
```
- #### Запусить headless service c Minio
```sh
kubectl apply -f https://raw.githubusercontent.com/express42/otus-platform-snippets/master/Module-02/Kuberenetes-volumes/minio-headless-service.yaml
```
- #### :star: Перенести ключи minio в secrets
secrets
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: minio-cred
type: Opaque
data:
  username: bWluaW8=
  password: bWluaW8xMjM=
```
statefulset
```yaml
env:
- name: MINIO_ACCESS_KEY
    valueFrom:
    secretKeyRef:
        name: minio-cred
        key: username
- name: MINIO_SECRET_KEY
    valueFrom:
    secretKeyRef:
        name: minio-cred
        key: password
```
## Как запустить проект:
 - Запустить команду
 ```shell
 git clone https://github.com/otus-kuber-2020-04/xom4ek_platform.git && \
 cd xom4ek_platform && \
 git checkout kubernetes-volumes && \
 kubectl apply -f kubernetes-volumes/secrets.yaml && \
 kubectl apply -f kubernetes-volumes/minio-statefulset.yaml && \
 kubectl apply -f kubernetes-volumes/minio-headless-service.yaml
 ```

## Как проверить работоспособность:

 - Выполнить команды:
  ```shell
  kubectl port-forward --address 0.0.0.0 pod/minio-0 9000:9000 &
  curl http://127.0.0.1:9000
  ```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
