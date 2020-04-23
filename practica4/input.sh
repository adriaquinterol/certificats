#!/bin/bash
# ASIX M11-Seguretat i alta disponibilitat
# Adria Quintero Lazaro
# ==============================================

#1.Executem les regles flush per esborrar la configuració actual:
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#2.Establim la politica per defecte (ACCEPT):
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

#Permetem totes les connexions desde localhost:
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
#Permetem el trafic de la nostra pròpia ip(192.168.0.22))
iptables -A INPUT -s 192.168.0.22 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.22 -j ACCEPT
# -----------------------------------------------------------
#3.Tanquem l’accés al servei local del host/firewall
# de web, telnet i ftp (tràfic tcp) i tftp (tràfic udp)
iptables -A INPUT -p tcp --dport 80 -j DROP
iptables -A INPUT -p tcp --dport 23 -j DROP
iptables -A INPUT -p tcp --dport 20:21 -j DROP

#4.Tanquem l’accés al servei “servei” local del host/firewall
# si l’origen és un host concret
# host 192.168.0.19 no pot accedir a ftp ni web
iptables -A INPUT -s 192.168.0.19 -p tcp --dport 81 -j DROP

#5.Es denega l’accés al servei “Postgresql” local del host/firewall
# si l’origen és una xarxa concreta
# xarxa 172.17.0.0/24 no té accés al servei postgresql
# qualsevol xarxa no té accés al servei telnet
iptables -A INPUT -s 172.17.0.0/24 -p tcp --dport 110 -j DROP
iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 143 -j DROP

#6.Tancar un servei a tots els hosts excepte els
# indicats.
# host 172.17.0.2 accés als serveis echo, daytime. Altres hosts denegat
# xarxa 172.17.0.0/24 accés al servei ssh, altres hosts/xarxes denegat
iptables -A INPUT -s 172.17.0.2 -p tcp --dport 7 -j ACCEPT
iptables -A INPUT -p tcp --dport 7 -j DROP
iptables -A INPUT -s 192.17.0.0/24 -p tcp --dport 13 -j ACCEPT
iptables -A INPUT -p tcp --dport 13 -j DROP

#7.Tancar els ports privilegiats 0-1023
# atenció: és molt perillós si no ens hem assegurat d’obrir serveis necessaris
iptables -A INPUT -p tcp --dport 1:1024 -j DROP
iptables -A INPUT -p udp --dport 1:1024 -j DROP
#Tancar explícitament ports o rangs de ports
iptables -A INPUT -p tcp --dport 10000 -j DROP
iptables -A INPUT -p tcp --dport 10000 -j DROP
iptables -A INPUT -p tcp --dport 2000:3000 -j DROP
# show
iptables -L
