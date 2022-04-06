#!/usr/bin/env bash

set -ex

kubectl config use-context docker-desktop
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f ingress-nginx-controller-deployment.yaml
# ConfigMaps
kubectl apply -f rabbitmq-conf-configmap.yaml,enabled-plugins-configmap.yaml
# Service RabbitMQ
kubectl apply -f rabbitmq-service.yaml
# RabbitMQ deployment
kubectl apply -f rabbitmq-deployment.yaml

kubectl wait --for=condition=available --timeout=300s deployment/rabbitmq
kubectl wait --for=condition=available --timeout=300s deployment/ingress-nginx-controller -n ingress-nginx
kubectl apply -f ingress-local.yaml
