#!/bin/bash

########################################################################
# Script: elnameserver.sh
# Descripcion: Configurar el nameserver de la raspberry
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
#source /home/pi/MiSimple/sistema/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
#hostname="$(cat /etc/hostname)"
#addrs=( $(arp -ni eth0 | grep -o '^[0-9][^ ]*') )
#default_ip="192.168.1.105"
#default_gtw="192.168.1.1"
#default_nmsrv="8.8.8.8"
#default="Si"
#default_ssid="nombre-de-tu-wifi"
#default_psk="password-de-tu-wifi"
#default_key="WPA-PSK"
# WPA/WPA2 TKIP/AES
#ip=192.168.1.105
#mask=255.255.255.0
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################
#hostname="$(cat /etc/hostname)"
# . variables.sh
. /SHConfig/db/variables.txt

elnameserver.sh(){
###################################################
#          OBTENER LA VARIABLE NAMESERVER         #
###################################################
echo -ne "-------------------------------------
ASIGNAR SERVIDORES DE NOMBRES    
-------------------------------------
El nameserver que has elegido es [$default_nmsrv] :

Escribe otro si quieres cambiarlo.
Despues pulsa [ENTER]: [$default_nmsrv]  " 

read -s nameservers
ip_address="${nameservers:=$default_nmsrv}"

sleep 3

if [ -z "$nameservers" ]
then
    conf_nmsrv=false
else
    conf_nmsrv=true
fi

if [ "$conf_nmsrv" = true ]; then
clear

echo -n "-------------------------------------
CONFIGURANDO EL NAMESERVER    
-------------------------------------"
echo " " 

sudo echo "static domain_name_servers=$gateway $ipadress " >> /etc/dhcpcd.conf
#

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'

clear
echo -n "-------------------------------------
RED CONFIGURADA       
-------------------------------------"
sleep 3

1

else

clear
echo -n "-------------------------------------
    NO SE HAN REALIZADO CAMBIOS       
-------------------------------------"
sleep 3

fi
clear;

}