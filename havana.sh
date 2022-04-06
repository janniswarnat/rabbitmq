#!/usr/bin/env bash

set -ex

kubectl config use-context havana
# ConfigMaps
kubectl apply -f rabbitmq-conf-configmap.yaml,enabled-plugins-configmap.yaml
# Service RabbitMQ
kubectl apply -f rabbitmq-service.yaml
# RabbitMQ deployment
kubectl apply -f rabbitmq-deployment.yaml
kubectl wait --for=condition=available --timeout=300s deployment/rabbitmq
#kubectl apply -f ingress.yaml
