#!/bin/bash
# ASIX M11-Seguretat i alta disponibilitat
# Adria Quintero Lazaro 
# ==============================================
#1.Regles Flush: buidar les regles actuals
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
#2.Establir la politica per defecte (DROP)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# Permetre totes les pròpies connexions via localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Permetre tot el trafic de la pròpia ip(192.168.0.22)
iptables -A INPUT -s 192.168.0.22 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.22 -j ACCEPT
# -----------------------------------------------------------
# consulta dns primari
iptables -A INPUT -s 80.58.61.250 -p udp -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -d 80.58.61.250 -p udp -m udp --dport 53 -j ACCEPT
# consulta dns secundari
iptables -A INPUT -s 80.58.61.254 -p udp -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -d 80.58.61.254 -p udp -m udp --dport 53 -j ACCEPT
# consulta ntp
iptables -A INPUT -p udp -m udp --dport 123 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --sport 123 -j ACCEPT
# ----------------------------------------------------------
# servei cups
iptables -A INPUT -p tcp --dport 631 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 631 -j ACCEPT
# port xinetd
iptables -A INPUT -p tcp --dport 3411 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 3411 -j ACCEPT
# port x11-x-forwarding
iptables -A INPUT -p tcp --dport 6010 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 6010 -j ACCEPT
# servei rpc
iptables -A INPUT -p tcp --dport 111 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 111 -j ACCEPT
# -----------------------------------------------------------
# icmp
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
# -----------------------------------------------------------
# servei ssh
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
# servei http
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
# servei daytime
iptables -A INPUT -p tcp --dport 13 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 13 -j ACCEPT
# servei echo
iptables -A INPUT -p tcp --dport 7 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 7 -j ACCEPT
# servei smtp
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 25 -j ACCEPT
# exit 0
# ==============================================================
# atencio: cal millorar aquestes regles!!! *****
# cal que nomes es permeti trafic relacionat *****
# ==============================================================
# navegar web
#iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
# accedir a servei echo
#iptables -A INPUT -p tcp --sport 7 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 7 -j ACCEPT
# accedir al servei daytime
#iptables -A INPUT -p tcp --sport 13 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT
# accedir al servei ssh
#iptables -A INPUT -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# -----------------------------------------------------------------
# ftp i tftp (trafic udp) *****
# -----------------------------------------------------------------
# oferir servei tftp
iptables -A INPUT -p udp --dport 69 -j ACCEPT
iptables -A OUTPUT -p udp --sport 69 -j ACCEPT
# accedir a serveis tftp externs
iptables -A INPUT -p udp --sport 69 -j ACCEPT
iptables -A OUTPUT -p udp --dport 69 -j ACCEPT
# pendent obrir ports dinamics
# oferir servei ftp
iptables -A INPUT -p tcp --dport 20:21 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 20:21 -j ACCEPT
# accdir a serveis ftp externs
iptables -A INPUT -p tcp --sport 20:21 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 20:21 -j ACCEPT
# pendent obrir ports dinamics!
# --------------------------------------------------------------
# Barrera per tancar els serveis/ports en cas de passar a drop
# ...
iptables -L
