# PRACTICA 1

## CERTIFICATS:

### Creació de l'entitat certificadora:

1. Primer de tot generem la clau privada encriptada amb 3des i amb passfrase "cakey"
```
$ openssl genrsa -des3 -out ca.key 1024
Generating RSA private key, 1024 bit long modulus (2 primes)
..........................................................................................................................+++++
....+++++
e is 65537 (0x010001)
Enter pass phrase for ca.key: cakey
Verifying - Enter pass phrase for ca.key: cakey
```
2. Després generem el certificat x509 pròpi de l'entitat, vàlid durant 365 dies, en format PEM i amb el nom de la companyia indicat (Veritat Absoluta):
```
$ openssl req -new -x509 -nodes -sha1 -days 365 -key ca.key -out ca.crt
Enter pass phrase for ca.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ca
State or Province Name (full name) []:Barcelona
Locality Name (eg, city) [Default City]:Barcelona
Organization Name (eg, company) [Default Company Ltd]:Veritat Absoluta
Organizational Unit Name (eg, section) []:Departament de certificats
Common Name (eg, your name or your server's hostname) []:VeritatAbsoluta            
Email Address []:admin@edt.org
```
3. Mostrem que els fitxers *ca.crt* i *ca.key* s'han creat correctament:
```
$ ll
total 8
-rw-rw-r-- 1 adria adria 1176 Apr  7 16:09 ca.crt
-rw------- 1 adria adria  963 Apr  7 16:01 ca.key
```
4. Mostrem també tant el contingut físic com el contingut lògic dels dos fitxers:

**ca.key**:

- Contingut físic:
```
$ cat ca.key
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: DES-EDE3-CBC,CE0E2F42E9ECE9AE

hAMfjk2OIY3Hk2EhZm+TQxdRCSqKhfPz/WAHT59MvX1DVBw34Hfiej7zbRUwetbu
QcGfEdY7CD167LDbvjbEefaJFFCYY9DqeFKwstSKkfEpzGwfErDNM5kHIg+CAzb1
+60xnfRXiahIPQCcp4paCqmLXsaFmCiNQumMKhhRFtoF4I/b2qjD43JYW8Vm5jvy
BuHRe76JbXIGZlehVGKovyH7fNXQrWOJy3uRicKhXPc/LPBaPJmR3j0g9i4q1yRa
5CLdEyIyrdJa0AFQ0Qz+gfLVCJfQDyLnB5z9UStVXnBjtwRVGrM1so/lQxW402AI
Ag1k/mI5m8GOKXRkA1sdE2795PIfqeksZX5Dbilgr4adoCiaRpkmi6qV1zk1gKoc
leIocfbinaaI0hvW6TmB7Nrw8XNHmkklI+V5OKeJXz3JIY791pXpkQM6M+SH7r5D
UKlLlvWeCYEDKMK5fdjD9v2utz+SghuICmvM3Tj+8xRQQ3rXw6VDJ3EE4xaWkRCZ
W5aWjmm8xRjHcmoGe27hXQ3FjAXQ5nmKKKlW5SVa8dM/wPpqe0T+phhU1cQxS1Ya
93DJHQ21khW8jui5UQ9cHLkXQwTDN0hE4NwAfPQ0OD3JQbLviYoYALJ05WfP8lu2
18pL1lyymceuIylvxoo4cK6td9sJmvYAr4zIUDl2fml1Mpkg9GCiYUZeYp6uVdtp
A8bX9LOqyLQQnbXx+oqmhR0qjz6XxeTBJaHMPyryxBMQ+23k1tPJjSI6AyNAeM/w
mMUq/+WfIddGuhSvgIvrtr9FHTYA5mjtG+819OHd3FclKUii3lWcyA==
-----END RSA PRIVATE KEY-----
```

- Contingut lògic:
```
$ openssl rsa -noout -text -in ca.key
Enter pass phrase for ca.key: cakey
RSA Private-Key: (1024 bit, 2 primes)
modulus:
    00:a9:e6:7c:f0:dd:b0:87:38:e8:2f:6c:f2:94:9d:
    31:a0:5e:a7:c8:3b:4d:f8:b0:f2:73:d9:bb:2c:e8:
    ff:af:b0:3c:c0:e6:f2:d6:ec:11:81:a0:a9:b1:25:
    68:13:2a:15:29:2c:56:5c:21:b3:14:ae:7b:73:25:
    3f:f4:84:83:6f:67:61:1c:36:f1:64:ce:43:40:ce:
    88:43:20:90:cd:1f:92:bc:a2:02:4f:b4:f6:d9:4c:
    28:25:a1:3d:5d:c5:79:ab:00:75:29:22:6f:ae:96:
    21:2a:7b:be:24:9a:ad:2e:f6:80:bd:1d:38:bd:fd:
    59:f2:46:dc:a2:aa:12:fc:01
publicExponent: 65537 (0x10001)
privateExponent:
    00:8c:ca:e0:fc:a5:69:95:15:16:6b:be:a7:e3:79:
    c4:57:36:39:69:d7:a3:4c:94:2d:c6:cd:46:ab:f7:
    c5:72:ac:e4:1b:a3:06:d8:0d:b6:90:2a:38:95:00:
    ff:96:ea:07:b1:1f:f9:cc:cd:6c:5e:96:1c:dd:15:
    a0:43:1b:d0:e2:15:ed:0b:fa:f3:11:75:ac:85:29:
    e0:ce:90:39:36:58:fb:b5:36:00:40:de:61:27:5a:
    7c:65:a1:76:d4:9f:a2:2d:11:ea:9c:30:94:cd:7c:
    8b:7b:14:bf:34:7f:c3:81:b8:c1:18:2e:50:f4:90:
    76:e3:7a:96:be:2d:12:23:01
prime1:
    00:d8:a8:bd:01:7f:24:fb:d7:9e:76:d5:76:42:4a:
    6d:05:5b:8a:9a:78:de:a8:d5:10:84:ce:14:91:28:
    7a:02:3b:35:be:2e:b6:0c:4f:21:65:bf:9e:29:fa:
    60:35:9c:31:7e:e6:d4:1d:3c:65:f3:0f:4e:9c:39:
    18:a2:50:e6:31
prime2:
    00:c8:c0:32:7c:0c:82:97:fb:e5:22:80:f3:39:5a:
    fa:01:88:b8:18:56:da:a3:34:11:fc:37:c8:6a:36:
    1c:a6:a4:4b:b1:44:5e:ca:f2:83:07:78:6d:01:38:
    1e:e2:98:0e:5d:64:be:6e:c4:9e:49:99:9b:fd:83:
    e6:c7:7e:6e:d1
exponent1:
    61:43:57:1e:4d:e2:df:80:4b:ae:53:63:f4:9c:8e:
    d6:c1:e2:b6:38:1e:d5:32:59:69:15:4e:dc:5f:8c:
    6e:66:00:59:71:84:de:7f:c3:a1:76:e5:5d:38:fe:
    69:f2:c5:b1:8f:94:97:cf:5e:81:40:54:ed:03:20:
    d0:f5:7a:71
exponent2:
    00:a5:99:0d:cc:10:51:c5:e7:8f:3b:28:1d:fa:e9:
    16:24:1f:d0:a4:9b:38:dd:b9:bd:40:4e:0f:af:b5:
    95:6a:cd:4a:77:1f:0c:06:e3:87:bc:a8:d5:5a:55:
    1d:fd:13:2b:7e:54:f5:55:d0:31:36:4b:55:47:0a:
    00:5b:fd:ea:91
coefficient:
    3e:b2:14:63:4d:4a:a7:3f:33:42:ac:d1:83:9e:04:
    ce:20:2c:dc:5b:53:e3:de:a8:95:d5:58:98:53:a0:
    62:e2:5d:4a:24:fa:55:ab:41:f2:2c:7d:56:2d:d4:
    fb:4b:6c:5d:18:bc:71:d7:f4:27:f7:f9:97:8a:7c:
    1d:42:56:b3

```

**ca.crt**:

- Contingut físic:
```
$ cat ca.crt 
-----BEGIN CERTIFICATE-----
MIIDODCCAqGgAwIBAgIUf+Yxn1IkvXvocTHDoLWgP1cdpLIwDQYJKoZIhvcNAQEF
BQAwga0xCzAJBgNVBAYTAmNhMRIwEAYDVQQIDAlCYXJjZWxvbmExEjAQBgNVBAcM
CUJhcmNlbG9uYTEZMBcGA1UECgwQVmVyaXRhdCBBYnNvbHV0YTEjMCEGA1UECwwa
RGVwYXJ0YW1lbnQgZGUgY2VydGlmaWNhdHMxGDAWBgNVBAMMD1Zlcml0YXRBYnNv
bHV0YTEcMBoGCSqGSIb3DQEJARYNYWRtaW5AZWR0Lm9yZzAeFw0yMDA0MDcxNDA5
NTdaFw0yMTA0MDcxNDA5NTdaMIGtMQswCQYDVQQGEwJjYTESMBAGA1UECAwJQmFy
Y2Vsb25hMRIwEAYDVQQHDAlCYXJjZWxvbmExGTAXBgNVBAoMEFZlcml0YXQgQWJz
b2x1dGExIzAhBgNVBAsMGkRlcGFydGFtZW50IGRlIGNlcnRpZmljYXRzMRgwFgYD
VQQDDA9WZXJpdGF0QWJzb2x1dGExHDAaBgkqhkiG9w0BCQEWDWFkbWluQGVkdC5v
cmcwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKnmfPDdsIc46C9s8pSdMaBe
p8g7Tfiw8nPZuyzo/6+wPMDm8tbsEYGgqbElaBMqFSksVlwhsxSue3MlP/SEg29n
YRw28WTOQ0DOiEMgkM0fkryiAk+09tlMKCWhPV3FeasAdSkib66WISp7viSarS72
gL0dOL39WfJG3KKqEvwBAgMBAAGjUzBRMB0GA1UdDgQWBBSIDxhvCjH2o4wSQYe/
xVK3CwteBjAfBgNVHSMEGDAWgBSIDxhvCjH2o4wSQYe/xVK3CwteBjAPBgNVHRMB
Af8EBTADAQH/MA0GCSqGSIb3DQEBBQUAA4GBAIo2pLrpY701jI/pZMaSIQJQwCMy
mp+ZC8ejVNnUC6WFOBhMh/EmW3+yheHe7ts6uYUdSMTzBK8ZEueEe084wINIRMBv
NvhrWN0KjDH+SuLrgPAxWUkJBeBlMlUI5qZlcsUFhACzfIMYW2RSVhy6cB9ohACK
kkiipRt6+PfQDdrP
-----END CERTIFICATE-----
```

- Contingut lògic:
```
$ openssl x509 -noout -text -in ca.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            7f:e6:31:9f:52:24:bd:7b:e8:71:31:c3:a0:b5:a0:3f:57:1d:a4:b2
        Signature Algorithm: sha1WithRSAEncryption
        Issuer: C = ca, ST = Barcelona, L = Barcelona, O = Veritat Absoluta, OU = Departament de certificats, CN = VeritatAbsoluta, emailAddress = admin@edt.org
        Validity
            Not Before: Apr  7 14:09:57 2020 GMT
            Not After : Apr  7 14:09:57 2021 GMT
        Subject: C = ca, ST = Barcelona, L = Barcelona, O = Veritat Absoluta, OU = Departament de certificats, CN = VeritatAbsoluta, emailAddress = admin@edt.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (1024 bit)
                Modulus:
                    00:a9:e6:7c:f0:dd:b0:87:38:e8:2f:6c:f2:94:9d:
                    31:a0:5e:a7:c8:3b:4d:f8:b0:f2:73:d9:bb:2c:e8:
                    ff:af:b0:3c:c0:e6:f2:d6:ec:11:81:a0:a9:b1:25:
                    68:13:2a:15:29:2c:56:5c:21:b3:14:ae:7b:73:25:
                    3f:f4:84:83:6f:67:61:1c:36:f1:64:ce:43:40:ce:
                    88:43:20:90:cd:1f:92:bc:a2:02:4f:b4:f6:d9:4c:
                    28:25:a1:3d:5d:c5:79:ab:00:75:29:22:6f:ae:96:
                    21:2a:7b:be:24:9a:ad:2e:f6:80:bd:1d:38:bd:fd:
                    59:f2:46:dc:a2:aa:12:fc:01
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                88:0F:18:6F:0A:31:F6:A3:8C:12:41:87:BF:C5:52:B7:0B:0B:5E:06
            X509v3 Authority Key Identifier: 
                keyid:88:0F:18:6F:0A:31:F6:A3:8C:12:41:87:BF:C5:52:B7:0B:0B:5E:06

            X509v3 Basic Constraints: critical
                CA:TRUE
    Signature Algorithm: sha1WithRSAEncryption
         8a:36:a4:ba:e9:63:bd:35:8c:8f:e9:64:c6:92:21:02:50:c0:
         23:32:9a:9f:99:0b:c7:a3:54:d9:d4:0b:a5:85:38:18:4c:87:
         f1:26:5b:7f:b2:85:e1:de:ee:db:3a:b9:85:1d:48:c4:f3:04:
         af:19:12:e7:84:7b:4f:38:c0:83:48:44:c0:6f:36:f8:6b:58:
         dd:0a:8c:31:fe:4a:e2:eb:80:f0:31:59:49:09:05:e0:65:32:
         55:08:e6:a6:65:72:c5:05:84:00:b3:7c:83:18:5b:64:52:56:
         1c:ba:70:1f:68:84:00:8a:92:48:a2:a5:1b:7a:f8:f7:d0:0d:
         da:cf
```

### Creació del certificat per al servidor:

1. Primer creem una clau privada per al servidor:

```
$ openssl genrsa -des3 -out server.key 1024
Generating RSA private key, 1024 bit long modulus (2 primes)
...................................................+++++
...................+++++
e is 65537 (0x010001)
Enter pass phrase for server.key: serverkey
Verifying - Enter pass phrase for server.key: serverkey
```

2. Després generem una petició de certificat request per poder-la enviar a l'entitat ceritficadora CA:
```
$ openssl req -new -key server.key -out server.csr
Enter pass phrase for server.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ca
State or Province Name (full name) []:Barcelona
Locality Name (eg, city) [Default City]:Barcelona
Organization Name (eg, company) [Default Company Ltd]:escola del treball
Organizational Unit Name (eg, section) []:departament d'informatica
Common Name (eg, your name or your server's hostname) []:ldap.edt.org
Email Address []:ldap@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:request password
An optional company name []:edt
```

3. Hem de crear també el fitxer de configuració per a la generació dels certificats:
```
$ cat ca.conf
basicConstraints = critical,CA:FALSE
extendedKeyUsage = serverAuth,emailProtection
```

4. L'autoritat CA signa el certificat del servidor:
```
$ openssl x509 -CA ca.crt -CAkey ca.key -req -in server.csr -days 365 -sha1 -extfile ca.conf -CAcreateserial -out server.crt
Signature ok
subject=C = ca, ST = Barcelona, L = Barcelona, O = escola del treball, OU = departament d'informatica, CN = ldap.edt.org, emailAddress = ldap@edt.org
Getting CA Private Key
Enter pass phrase for ca.key: cakey
```

5. Mostrem el número de serie que ha generat la CA per al certificat emés:
```
$ cat ca.srl 
245CD57687AAE218469FFCA6E3BC6EFA1031F0E0
```

6. Validem el certificat sol·licitat amb la clau privada del servidor:
```
$ openssl rsa -noout -modulus -in server.key | openssl md5
Enter pass phrase for server.key:
(stdin)= d3ba0298daa154e4a099d43a35115d9e
```

## SERVIDOR LDAP:

### Construcció de la imatge del servidor ldap:

1. Primer de tot hem de crear els fitxers necessaris per a generar la imatge:

    - [Dockerfile](./ldaps/Dockerfile): Fitxer de construcció de la imatge.
    - [DB_CONFIG](./ldaps/DB_CONFIG): Fitxer de configuració de la base de dades de ldap.
    - [edt.org.ldif](./ldaps/edt.org.ldif): Fitxer que conté les organitzacions i usuaris a inserir al servidor ldaps.
    - [install.sh](./ldaps/install.sh): Script que insereix les dades i fitxers necessaris al servidor ldaps.
    - [ldap.conf](./ldaps/ldap.conf): Fitxer que defineix la configuració del client ldaps.
    - [slapd.conf](./ldaps/slapd.conf): Fitxer de configuració del servidor ldap.
    - [startup.sh](./ldaps/startup.sh): Script que executa el fitxer [install.sh](./ldaps/install.sh) i inicia el servei slapd.
    - [ca.crt](./ldaps/ca.crt): Certificat de l'entitat certificadora que hem generat anteriorment.
    - [server.crt](./ldaps/server.crt): Certificat del servidor que hem generat anteriorment.
    - [server.key](./ldaps/server.key): Clau privada del servidor que hem generat anteriorment.

2. Una vegada ja tenim els fitxers, generem la imatge des del mateix directori:

```
$ docker build -t adriaquintero61/ldapserver19:ldaps .
Sending build context to Docker daemon 23.04 kB
Step 1/10 : FROM fedora:27
 ---> f89698585456
...
Step 10/10 : CMD /opt/docker/startup.sh
 ---> Running in da33487e8a1f
 ---> a309cbfebd33
Removing intermediate container da33487e8a1f
Successfully built a309cbfebd33
```

3. Iniciem el servidor ldaps en detach:

```
$ docker run --rm -h ldap.edt.org --name ldap.edt.org -d adriaquintero61/ldapserver19:ldaps
15075ef3301d925750e5ed5704dbc875d9697594c9f1fa1953b65cf7e032fe01
```

- Realitzem les 3 proves per les quals podría estar fallant la connexió amb els certificats:
```
[root@ldap docker]# ldapsearch -x -LLL -Z -b 'dc=edt,dc=org' -h 172.17.0.2 dn
ldap_start_tls: Connect error (-11)
	additional info: TLS error -12227:SSL peer was unable to negotiate an acceptable set of security parameters.
ldap_result: Can't contact LDAP server (-1)
[root@ldap docker]# ldapsearch -vx -LLL -Z -b 'dc=edt,dc=org' -h 172.17.0.2 dn
ldap_initialize( ldap://172.17.0.2 )
ldap_start_tls: Connect error (-11)
	additional info: TLS error -12227:SSL peer was unable to negotiate an acceptable set of security parameters.
ldap_result: Can't contact LDAP server (-1)
[root@ldap docker]# ldapsearch -x -LLL -ZZ -b 'dc=edt,dc=org' -h ldap.edt.org dn | head -n2
ldap_start_tls: Connect error (-11)
	additional info: TLS error -12227:SSL peer was unable to negotiate an acceptable set of security parameters.
```