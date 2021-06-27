#!/bin/sh

podName=$1
podId=$(kubectl get pod --selector=app.kubernetes.io/name=avengers-$podName -o jsonpath="{.items[0].metadata.name}")
echo "Shelling to: $podId"

kubectl exec -it $podId -- /bin/sh