# PRACTICA 2

## EXEMPLE 3:

### CERTIFICATS:

1. Primer de tot hem de crear els fitxers de configuració d'extensions "ext.server.conf" i "ext.client.conf":
```
$ cat ext.server.conf 
basicConstraints = CA:FALSE
nsCertType = server
nsComment = "OpenSSL Generated Server Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
extendedKeyUsage = serverAuth
keyUsage = digitalSignature, keyEncipherment

$ cat ext.client.conf 
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always

```

2. Creem una nova entitat certificadora amb el mateix nom "Veritat absoluta" amb claus i certificats amb l'extensió ".pem":

- Clau de la CA:
```
$ openssl genrsa -des3 -out ca.pem 1024 
Generating RSA private key, 1024 bit long modulus (2 primes)
............................................+++++
..................................+++++
e is 65537 (0x010001)
Enter pass phrase for ca.pem:
Verifying - Enter pass phrase for ca.pem:
```

- Certificat de la CA:
```
$ openssl req -new -x509 -nodes -sha1 -days 365 -key ca.pem -out cacert.pem
Enter pass phrase for ca.pem:
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
Common Name (eg, your name or your server's hostname) []:VeritatAbsoluta
Email Address []:admin@edt.org
```


3. Generem la clau, la petició i el certificat del servidor (May) amb la CA Veritat Absoluta:

- Clau del servidor:
```
$ openssl genrsa -out serverkey.vpn.pem
Generating RSA private key, 2048 bit long modulus (2 primes)
...........+++++
......................................+++++
e is 65537 (0x010001)

```
- Petició (request) del certificat:
```
$ openssl req -new -key serverkey.vpn.pem -out serverreq.vpn.pem
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
Organization Name (eg, company) [Default Company Ltd]:Escola del treball
Organizational Unit Name (eg, section) []:Departament d'informatica
Common Name (eg, your name or your server's hostname) []:may
Email Address []:may@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:serverkey
An optional company name []:^C
[adria@may may_server]$ openssl req -new -key serverkey.vpn.pem -out serverreq.vpn.pem
[adria@may may_server]$ openssl req -new -key serverkey.vpn.pem -out serverreq.vpn.pem
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
Common Name (eg, your name or your server's hostname) []:may
Email Address []:may@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:request password
An optional company name []:edt
```

- Signem la petició i generem el certificat:
```
$ openssl x509 -CAkey ../ca/ca.pem -CA ../ca/cacert.pem -req -in serverreq.vpn.pem -days 3650 -CAcreateserial -extfile ext.server.conf -out servercert.vpn.pem
Signature ok
subject=C = ca, ST = Barcelona, L = Barcelona, O = escola del treball, OU = departament d'informatica, CN = may, emailAddress = may@edt.org
Getting CA Private Key
Enter pass phrase for ../ca/ca.pem: cakey
```

4. Generem la clau, petició i el certificat del client (june):

- Generem la clau:
```
$ openssl genrsa -out clientkey.1vpn.pem
Generating RSA private key, 2048 bit long modulus (2 primes)
.....+++++
....................+++++
e is 65537 (0x010001)
```

- Generem la petició (request):
```
$ openssl req -new -key clientkey.1vpn.pem -out clientreq.1vpn.pem
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ca
State or Province Name (full name) []:barcelona
Locality Name (eg, city) [Default City]:barcelona
Organization Name (eg, company) [Default Company Ltd]:escola del treball
Organizational Unit Name (eg, section) []:departament d'informatica
Common Name (eg, your name or your server's hostname) []:june
Email Address []:june@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:request password
An optional company name []:edt
```

- Signem la petició i generem el certificat:
```
$ openssl x509 -CAkey ../ca/ca.pem -CA ../ca/cacert.pem -req -in clientreq.1vpn.pem -days 3650 -CAcreateserial -extfile ext.client.conf -out clientcert.1vpn.pem
Signature ok
subject=C = ca, ST = barcelona, L = barcelona, O = escola del treball, OU = departament d'informatica, CN = june, emailAddress = june@edt.org
Getting CA Private Key
Enter pass phrase for ../ca/ca.pem:cakey
```

### COMANDES I CONFIGURACIÓ PER LA CONNEXIÓ OPENVPN:

5. Una vegada creats els certificats, ens hem d'assegurar de que el fitxer "/etc/hosts" de cada maquina esta configurat apropiadament:
- May (server):
```
[adria@may may_server]$ tail -n1 /etc/hosts
192.168.0.19  june	
```

- June (client):
```
[adria@june june_client]$ tail -n1 /etc/hosts
192.168.0.22 may
```

6. Per tal de que el certificat funcioni correctament, el hostname de la maquina ha de conincidir amb el "CN" del certificat que li pertany, de manera que si no s'ha creat adequadament el certificat, i no volem tornar-lo a crear, una altre opció es canviar el hostname de la màquina per tal de que coincideixi amb el "CN" del certificat. Això ho podem fer amb la següent comanda:
```
hostnamectl set-hostname nom-del-host
```

7. Un cop realitzats els pasos anteriors, ja podem executar les següents comandes per crear la connexió VPN:

- Executem la comanda al host May(server):
```
[adria@may may_server]$ sudo openvpn --remote june --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dh dh2048.pem --ca cacert.pem --cert servercert.vpn.pem --key serverkey.vpn.pem --reneg-sec 60
Sat Apr 11 15:45:47 2020 disabling NCP mode (--ncp-disable) because not in P2MP client or server mode
Sat Apr 11 15:45:47 2020 OpenVPN 2.4.8 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Nov  1 2019
Sat Apr 11 15:45:47 2020 library versions: OpenSSL 1.1.1d FIPS  10 Sep 2019, LZO 2.08
Sat Apr 11 15:45:47 2020 NOTE: your local LAN uses the extremely common subnet address 192.168.0.x or 192.168.1.x.  Be aware that this might create routing conflicts if you connect to the VPN server from public locations such as internet cafes that use the same subnet.
Sat Apr 11 15:45:47 2020 TUN/TAP device tun1 opened
Sat Apr 11 15:45:47 2020 /sbin/ip link set dev tun1 up mtu 1500
Sat Apr 11 15:45:47 2020 /sbin/ip addr add dev tun1 local 10.4.0.1 peer 10.4.0.2
Sat Apr 11 15:45:47 2020 TCP/UDP: Preserving recently used remote address: [AF_INET]192.168.0.19:1194
Sat Apr 11 15:45:47 2020 UDP link local (bound): [AF_INET][undef]:1194
Sat Apr 11 15:45:47 2020 UDP link remote: [AF_INET]192.168.0.19:1194
```

- Mentre l'altre host esta esperant la connexió, executem la següent comanda a June(client):
```
[adria@june june_client]$ sudo openvpn --remote may --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --tls-client --ca cacert.pem --cert clientcert.1vpn.pem --key clientkey.1vpn.pem --reneg-sec 60
```

- Ara que ja tenim el túnel establert i funcionant, comprovem amb un "ping" que aquesta connexió funciona:

    - Ping de may a june:
    ```
    [adria@may may_server]$ ping 10.4.0.2
    PING 10.4.0.2 (10.4.0.2) 56(84) bytes of data.
    64 bytes from 10.4.0.2: icmp_seq=1 ttl=64 time=1.14 ms
    64 bytes from 10.4.0.2: icmp_seq=2 ttl=64 time=1.44 ms
    64 bytes from 10.4.0.2: icmp_seq=3 ttl=64 time=2.72 ms
    64 bytes from 10.4.0.2: icmp_seq=4 ttl=64 time=1.05 ms
    ```
    - Ping de june a may:
    ```
    [adria@june ~]$ ping 10.4.0.1
    PING 10.4.0.1 (10.4.0.1) 56(84) bytes of data.
    64 bytes from 10.4.0.1: icmp_seq=1 ttl=64 time=2.38 ms
    64 bytes from 10.4.0.1: icmp_seq=2 ttl=64 time=1.24 ms
    64 bytes from 10.4.0.1: icmp_seq=3 ttl=64 time=56.0 ms
    64 bytes from 10.4.0.1: icmp_seq=4 ttl=64 time=0.984 ms
    ```