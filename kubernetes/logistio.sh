#!/bin/bash

podName=$1
if [[ $podName == "app" ]]; then
  namespace=mediumtrust
  selector=app.kubernetes.io/name=avengers-app
else
  namespace=lowtrust
  selector=app.kubernetes.io/name=avengers-httpd
fi

podId=$(kubectl get pod --selector=$selector -n $namespace -o jsonpath="{.items[0].metadata.name}")
kubectl logs $podId -n $namespace --follow -c istio-proxy
