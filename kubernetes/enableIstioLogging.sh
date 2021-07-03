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
istioctl pc log $podId -n $namespace --level=debug
