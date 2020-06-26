#!/bin/bash
kubectl get configmap kube-proxy -n kube-system -o yaml | \
  sed -e 's/strictARP: false/strictARP: true/' | \
  sed -e 's/mode: ""/mode: "ipvs"/' | \
  kubectl apply -f - -n kube-system
kubectl --namespace kube-system delete pod --selector='k8s-app=kube-proxy'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl wait --for=condition=available --timeout=600s deployment controller -n metallb-system
kubectl apply -f metallb-config.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl wait --for=condition=available --timeout=600s deployment ingress-nginx-controller -n ingress-nginx
kubectl apply -f nginx-lb.yaml
kubectl apply -f web-deploy.yaml
kubectl apply -f web-svc-cip.yaml
kubectl apply -f web-svc-lb.yaml
kubectl apply -f web-svc-headless.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
kubectl wait --for=condition=available --timeout=600s deployment kubernetes-dashboard -n kubernetes-dashboard
kubectl apply -f web-ingress.yaml
kubectl apply -f coredns/external-dns.yaml
kubectl apply -f dashboard/ingress.yaml
kubectl apply -f canary/cm.yaml
kubectl apply -f canary/pods.yaml
kubectl apply -f canary/ingress.yaml
kubectl apply -f canary/services.yaml
