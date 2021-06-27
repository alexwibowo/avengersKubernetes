# Kubernetes Demo

## Java Application
``` 
./gradlew clean build dockerBuildImage
```

## HTTPD Reverse Proxy image
``` 
docker build -t avengers-httpd:1.0 .
```

## Install Istio
``` 
istioctl install --set profile=default -y
✔ Istio core installed                                                                                                                                                                                
✔ Istiod installed                                                                                                                                                                                    
✔ Ingress gateways installed                                                                                                                                                                          
✔ Installation complete                                                                                                                                                                               Thank you for installing Istio 1.10.  Please take a few minutes to tell us about your install/upgrade experience!  https://forms.gle/KjkrDnMPByq7akrYA
```
Note: I had to give plenty of memory before doing this. Otherwise it will fail:
```
istioctl install --set profile=default -y
✔ Istio core installed                                                                                                                                                                                                                                                                                                    
- Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                    Processing resources for Istiod. Wait  Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                                                         


- Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                                                         
✘ Istiod encountered an error: failed to wait for resource: resources not ready after 5m0s: timed out waiting for the condition                                                                       
Deployment/istio-system/istiod                                         
...
```

``` 
kubectl label namespace default istio-injection=enabled
```


```
istioctl proxy-status   

NAME                                                  CDS        LDS        EDS        RDS          ISTIOD                      VERSION
istio-ingressgateway-7d97f78f5-gd69w.istio-system     SYNCED     SYNCED     SYNCED     NOT SENT     istiod-69b568db5f-brvvn     1.10.2

```

## Uninstall

``` 
istioctl manifest generate --set profile=default | kubectl delete --ignore-not-found=true -f -
```

``` 
kubectl delete namespace istio-system
```

``` 
kubectl label namespace default istio-injection-
```



