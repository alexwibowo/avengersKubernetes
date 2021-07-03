## Generate Certificates

### Root certificate
First we need to create root (CA) certificate:
```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj "/O=The Avengers/CN=avengers.local" -keyout avengers.local.key -out avengers.local.crt
```
```
openssl x509 -text -noout -in avengers.local.crt
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 15591668649221337320 (0xd860bc073c6eb0e8)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: O=The Avengers, CN=avengers.local
        Validity
            Not Before: Jun 26 13:39:17 2021 GMT
            Not After : Jun 26 13:39:17 2022 GMT
        Subject: O=The Avengers, CN=avengers.local
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:f8:96:1b:5a:3d:1a:e7:5d:b6:46:ed:6d:69:b0:
                    33:c5:d2:72:0f:7b:4f:c0:c5:09:7b:b3:32:79:9e:
                    d5:e0:f5:ea:f9:77:ae:53:39:c4:9c:c7:e3:72:82:
                    51:e4:18:07:7d:4d:80:6b:78:40:59:69:78:9e:7a:
                    c1:c8:85:17:f1:e0:f6:27:2f:bf:7d:d1:19:a1:0b:
                    3d:2f:a4:ba:1b:41:d8:5c:46:36:0e:99:1f:37:17:
                    bf:d5:10:54:a1:7e:59:c5:1a:01:76:40:65:57:47:
                    77:39:5c:68:3b:b4:6d:95:7a:b4:bd:40:df:75:c9:
                    d9:e2:30:fb:9e:c7:7d:60:75:fa:c9:22:6c:52:23:
                    0f:ba:56:aa:41:01:65:ba:4c:e8:c1:ab:a3:7f:c7:
                    5f:83:7c:47:c1:0e:7f:a8:d0:4b:e2:1e:55:d9:06:
                    df:ac:dd:9a:3b:d5:48:90:7e:ef:1b:6f:b2:f4:a3:
                    b8:c2:82:1c:ed:2a:fa:f6:88:a8:32:20:38:4e:93:
                    ff:d5:0f:00:61:41:cc:3e:b5:84:20:79:f3:d8:f2:
                    5d:2d:ac:a9:5b:c9:b1:40:55:51:46:14:36:a7:de:
                    65:e8:a3:d5:b2:bd:69:72:e5:3a:ea:4a:2c:6d:5c:
                    83:d1:13:41:04:cc:4f:18:86:f6:f2:75:7c:c1:6e:
                    43:77
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         ae:b7:b4:4f:ac:98:dc:2e:0b:5b:99:8d:ea:ef:56:8c:5b:a7:
         a7:37:6c:c1:c3:87:cc:ce:b1:fd:d8:14:cd:3d:ec:f4:07:f9:
         4b:88:0f:67:29:bb:be:4a:af:f0:7f:4d:cb:0e:5c:86:bd:69:
         43:14:86:be:59:17:37:86:49:47:40:cb:9b:35:ae:7a:dd:1d:
         a1:47:da:f8:69:df:e2:0c:64:47:dd:26:9c:d9:a1:25:93:c9:
         6f:86:8a:4c:98:84:a9:1d:c6:12:66:9d:04:b4:44:49:38:a4:
         a2:84:2d:95:f3:0e:3d:5e:3b:2e:8f:e1:dd:98:82:20:df:b5:
         df:a3:79:e4:68:a6:98:34:26:d6:5e:a8:fb:bc:f2:12:79:3e:
         bd:6b:79:c8:b1:85:b6:bf:d9:d6:47:fb:63:12:01:2c:c2:cf:
         e8:c7:7a:99:9c:bf:69:d1:a7:d4:25:5b:a1:61:df:7f:7a:6b:
         9e:a9:88:f9:e0:1f:0d:27:81:b7:b4:6d:1f:8b:0e:15:d6:8d:
         e0:eb:33:39:e1:b3:4f:54:40:2d:ad:5f:64:71:78:e3:3b:35:
         22:73:9c:21:e8:fb:53:94:83:9b:3b:51:3a:5f:16:11:2a:76:
         14:4c:34:3d:5e:df:e8:4f:83:d0:46:d9:2d:c4:b8:3d:4e:fe:
         35:8a:f8:52

```

### LowTrust Client certificate

#### Client Certificate Signing Request
Create ```request.txt``` file with the following content:
```
[req]
distinguished_name=req
[san]
subjectAltName=DNS:avengers.local
```

Using Powershell, we will generate CSR.
This step will generate ```lowtrust.avengers.local.csr``` that we will use in the next step to generate the server certificate.
It also generates ```lowtrust.avengers.local.key``` (the private key)
```
openssl req -out lowtrust.avengers.local.csr -newkey rsa:2048 -nodes -keyout lowtrust.avengers.local.key  -subj "/CN=lowtrust.avengers.local/O=The Avengers" -reqexts san -config request.txt
Generating a 2048 bit RSA private key
.............................................+++
.........................................................................+++
writing new private key to 'lowtrust.avengers.local.key'
-----
```

#### Client Certificate
Now lets sign the server certificate. We will use:
* avengers.local.crt
* avengers.local.key
* lowtrust.avengers.local.csr (output from previous)
```
openssl  x509 -req -days 365 -CA avengers.local.crt -CAkey avengers.local.key -set_serial 0 -in lowtrust.avengers.local.csr -out lowtrust.avengers.local.crt -extensions san -extfile request.txt
Signature ok
subject=/CN=lowtrust.avengers.local/O=The Avengers
Getting CA Private Key
```
This step will generate ```lowtrust.avengers.local.crt```.

Finally, lets verify the server certificate:
```
openssl x509 -text -noout -in lowtrust.avengers.local.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: O=The Avengers, CN=avengers.local
        Validity
            Not Before: Jun 26 13:44:53 2021 GMT
            Not After : Jun 26 13:44:53 2022 GMT
        Subject: CN=lowtrust.avengers.local, O=The Avengers
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:bd:8c:e3:44:94:6f:88:00:33:89:61:b2:08:36:
                    a7:e5:e0:f4:dc:19:03:bb:9f:ab:2c:15:f2:de:83:
                    da:60:64:ca:00:ae:dc:8e:cb:24:21:8c:ab:97:68:
                    4d:af:e5:66:61:d7:57:53:ee:c2:5f:5a:df:a6:94:
                    ba:e0:a2:10:5b:83:8c:0f:f0:ba:31:36:bd:c2:a2:
                    b5:a5:94:28:64:56:ca:15:e9:a4:7e:10:60:45:cd:
                    26:a7:b2:5f:11:d0:d7:80:60:e6:f3:12:60:e2:e5:
                    30:8b:8f:51:74:b0:82:5a:7e:29:4b:f7:fa:f2:69:
                    57:68:ae:64:5f:23:23:b3:dc:30:07:98:15:de:ec:
                    4a:11:41:a2:f4:88:58:04:4b:64:f3:b1:45:fc:c5:
                    ac:91:81:0a:11:99:48:2e:da:af:1a:f3:5a:01:5c:
                    75:8f:e9:9c:7e:a1:37:31:8d:26:08:57:52:b5:7d:
                    09:09:3b:19:2e:3d:6b:94:13:45:17:a1:a1:de:15:
                    bd:7d:22:32:64:37:74:4a:ac:c4:99:71:5f:2d:7d:
                    74:04:66:d9:98:68:90:59:d6:44:9b:7b:28:7c:d1:
                    af:08:45:64:32:12:fe:45:50:58:50:3e:f5:24:ea:
                    81:58:09:d4:0a:c3:3b:47:05:16:f0:f6:1f:6e:5a:
                    a8:c9
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Alternative Name: 
                DNS:avengers.local
    Signature Algorithm: sha1WithRSAEncryption
         05:3a:c1:2b:d0:aa:2a:8c:e9:f8:4b:bc:f7:5d:d9:94:7e:c4:
         c8:f6:ea:11:87:d0:02:c1:c7:b8:c9:9d:c5:1b:6f:68:38:f1:
         59:b1:27:09:b1:4e:36:03:44:a6:a9:2c:f3:a7:55:7a:ce:a1:
         39:c3:12:01:4d:e4:0b:34:22:7f:b8:4c:b7:3c:8d:a6:85:48:
         e8:b0:22:19:88:f1:15:62:43:1e:be:51:66:c8:1f:85:a9:b7:
         b4:3f:b4:89:cd:ad:92:30:09:b2:b7:ca:f1:91:65:e0:1c:6a:
         00:e4:3d:79:82:96:8c:a6:c2:37:c9:bc:c4:c7:a0:72:1d:2a:
         02:57:46:58:67:d0:b4:5e:97:ee:40:87:37:12:bc:60:07:4e:
         1f:9b:c6:b3:c1:79:5f:de:37:5f:75:4e:9d:ad:43:16:53:e2:
         98:93:7b:56:aa:e4:2f:e5:43:9f:35:e5:20:8e:e0:72:2e:17:
         8c:e5:08:95:56:3d:de:6d:ca:0e:06:17:e0:70:4d:5c:c5:d7:
         fc:70:66:fd:92:04:16:ba:28:5d:f7:99:33:3a:1b:6d:6c:92:
         d6:14:b2:d2:f5:0f:de:21:c9:05:96:d5:80:22:34:92:41:9e:
         c2:32:47:f0:64:6c:00:02:a7:3b:8f:80:84:7a:0f:6f:97:a1:
         f3:8a:99:08
```

### MediumTrust Client certificate

#### Client Certificate Signing Request

```
openssl req -out mediumtrust.avengers.local.csr -newkey rsa:2048 -nodes -keyout mediumtrust.avengers.local.key  -subj "/CN=mediumtrust.avengers.local/O=The Avengers" -reqexts san -config request.txt
Generating a 2048 bit RSA private key
.............................................+++
.........................................................................+++
writing new private key to 'mediumtrust.avengers.local.key'
-----
```

#### Client Certificate

```
openssl  x509 -req -days 365 -CA avengers.local.crt -CAkey avengers.local.key -set_serial 0 -in mediumtrust.avengers.local.csr -out mediumtrust.avengers.local.crt -extensions san -extfile request.txt
Signature ok
subject=/CN=mediumtrust.avengers.local/O=The Avengers
Getting CA Private Key
```

## Configure TLS Ingress Gateway
We will now install the certificate on Kubernetes secret.

```
kubectl create -n istio-system secret tls default-lowtrust-avengers-local-credential --key=lowtrust.avengers.local.key --cert=lowtrust.avengers.local.crt
secret/default-lowtrust-avengers-local-credential created
```

``` 
kubectl create -n istio-system secret tls default-mediumtrust-avengers-local-credential --key=mediumtrust.avengers.local.key --cert=mediumtrust.avengers.local.crt
secret/default-mediumtrust-avengers-local-credential created
```

## Configure Host
```
127.0.0.1 lowtrust.avengers.local
127.0.0.1 mediumtrust.avengers.local
```
Remember, ```lowtrust.avengers.local``` is the DNS we chose to generate our certificate with