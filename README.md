# Kubernetes Demo

How to run the demo
1. Build the Java Application
2. Build HTTPD docker image
3. Install Istio
4. Go to [kubernetes](kubernetes) folder, run
   ``` 
   helm install cr1 avengers
   ```   


## Java Application
``` 
./gradlew clean build dockerBuildImage
```
This will build and push the docker image for the Spring Boot java application. 
It is a fairly simple app, with single HTML page. Nothing fancy here! The application itself is running on port 8080.
So you can run the docker image directly if you wish:
``` 
docker run --rm --name avengers -p 8080:8080 avengers-app:1.0
``` 
and see from your browser: http://localhost:8080/avengers/index.html

## HTTPD Reverse Proxy image
You can build this image from within the [httpd](httpd) directory.
``` 
docker build -t avengers-httpd:1.0 .
```
Note that the reverse proxy config is here: [proxy.conf](httpd/conf/proxy.conf)

## Install Istio
Istio is required. I'm using 'default' profile
``` 
istioctl install --set profile=default -y
✔ Istio core installed                                                                                                                                                                                
✔ Istiod installed                                                                                                                                                                                    
✔ Ingress gateways installed                                                                                                                                                                          
✔ Installation complete                                                                                                                                                                               Thank you for installing Istio 1.10.  Please take a few minutes to tell us about your install/upgrade experience!  https://forms.gle/KjkrDnMPByq7akrYA
```
Note: I had to give plenty of memory before doing this. Otherwise it will fail like below:
```
istioctl install --set profile=default -y
✔ Istio core installed                                                                                                                                                                                                                                                                                                    
- Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                    Processing resources for Istiod. Wait  Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                                                         


- Processing resources for Istiod. Waiting for Deployment/istio-system/istiod                                                                                                                         
✘ Istiod encountered an error: failed to wait for resource: resources not ready after 5m0s: timed out waiting for the condition                                                                       
Deployment/istio-system/istiod                                         
...
```

Next, enable Istio injection
``` 
kubectl label namespace default istio-injection=enabled
```


```
istioctl proxy-status   

NAME                                                  CDS        LDS        EDS        RDS          ISTIOD                      VERSION
istio-ingressgateway-7d97f78f5-gd69w.istio-system     SYNCED     SYNCED     SYNCED     NOT SENT     istiod-69b568db5f-brvvn     1.10.2

```

### Uninstall Istio
If you wish... here are the steps
``` 
istioctl manifest generate --set profile=default | kubectl delete --ignore-not-found=true -f -
kubectl delete namespace istio-system
kubectl label namespace default istio-injection-
```




