#!/bin/bash
# ASIX M11-Seguretat i alta disponibilitat
# @edt 2015
# ==============================================
# Exemples de regles OUTPUT
# host i19 (192.168.2.49)
# paquets: xinetd, telnet, telnet-server, httpd, uw-imap
# fets amb xinetd: echo-stream(7), daytime-stream(13),
# daytime2(82), ipop3(110), imap(143), https2(81)
# stand-alone: httpd, xinetd
# ===============================================
# Activar si el host ha de fer de router
#echo 1 > /proc/sys/net/ipv4/ip_forward
#1.Regles Flush: buidar les regles actuals
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
#2.Establir la politica per defecte (ACCEPT o DROP)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
# Permetre totes les pròpies connexions via localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Permetre tot el trafic de la pròpia ip(192.168.0.22)
iptables -A INPUT -s 192.168.0.22 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.22 -j ACCEPT
# -----------------------------------------------------------
#3.Tanquem l’accés al servei de web, telnet i ftp (tràfic tcp)
# i tftp (tràfic udp) de fora
iptables -A OUTPUT -p tcp --dport 80 -j DROP
iptables -A OUTPUT -p tcp --dport 23 -j DROP
iptables -A OUTPUT -p tcp --dport 20:21 -j DROP
#4.Tanquem l'acces a un servei extern excepte a un servidor forani concret
iptables -A OUTPUT -d 192.168.0.19 -p tcp --dport 81 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 81 -j DROP
#5.Tanquem l’accés al servei pop3 si el desti és
# una xarxa diferent a la 192.168.0.0/24:
iptables -A OUTPUT -d 192.168.0.0/24 -p tcp --dport 110 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 110 -j DROP
#6.Tancar acces al servei daytime a una xarxa concreta excepte als hosts indicats.
# 192.168.0.2/24
iptables -A OUTPUT -d 192.168.0.2 -p tcp --dport 13 -j ACCEPT
iptables -A OUTPUT -d 192.168.2.0/24 -p tcp --dport 13 -j DROP
# Tancar els ports privilegiats 0-1023
# atenció: és molt perillós si no ens hem assegurat d’obrir serveis necessaris
iptables -A OUTPUT -p tcp --dport 1:1024 -j DROP
iptables -A OUTPUT -p udp --dport 1:1024 -j DROP
# Tancar explícitament ports o rangs de ports
iptables -A OUTPUT -p tcp --dport 10000 -j DROP
iptables -A OUTPUT -p tcp --dport 10000 -j DROP
iptables -A OUTPUT -p tcp --dport 2000:3000 -j DROP
#Show
iptables -L
