This step is to add another SSL port, 445.

Complete explanation is on https://www.dangtrinh.com/2019/09/how-to-open-custom-port-on-istio.html

1. Export the current configuration of the istio-ingressgateway
   ``` 
   kubectl -n istio-system get service istio-ingressgateway -o yaml > istio_ingressgateway.yaml
   ```
2. Edit the istio_ingressgateway.yaml, add the new port you want
   ``` 
     - name: avengershttps
       nodePort: 32700
       port: 445
       protocol: TCP
       targetPort: 8443
   ```
3. Apply the new configuration
   ``` 
    kubectl apply -f istio_ingressgateway.yaml
   ```
4. Check if the new port running
   ```
   kubectl describe svc istio-ingressgateway -n istio-system | less
   ```   
