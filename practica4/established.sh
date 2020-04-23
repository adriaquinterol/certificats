#!/bin/bash
# ASIX M11-Seguretat i alta disponibilitat
# Adria Quintero Lazaro
# ===============================================
# Regles Flush: buidar les regles actuals
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
# Establir la politica per defecte (ACCEPT)
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
#1.Tanquem l’accés al propi servei web
# de fora cap al router/firewall, però el router/firewall si pot navegar
iptables -A INPUT -p tcp --dport 80 -j DROP
iptables -A INPUT -p tcp --dport 443 -j DROP
/sbin/iptables -A INPUT -p tcp -m tcp --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -m tcp --sport 443 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT
#2.es denega que des del router/firewall s'accdeixi al servei
# web(80,443) però s'ofereix aquest servei a l'exterior
/sbin/iptables -A OUTPUT -p tcp --dport 80 -j DROP
/sbin/iptables -A OUTPUT -p tcp --dport 443 -j DROP
/sbin/iptables -A INTPUT -p tcp -m tcp --dport 80 -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A INTPUT -p tcp -m tcp --dport 443 -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --sport 443 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Show
iptables -L
