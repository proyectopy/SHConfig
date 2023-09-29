#!/bin/bash

########################################################################
# Script: elhostname.sh
# Descripcion: Configurar el hostname de la raspberry
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

elhostname.sh(){

###################################################
#              CONFIGURAR EL HOSTNAME             #
###################################################

clear
echo -ne "-------------------------------------
CAMBIAR EL NOMBRE DE HOST      
-------------------------------------
El nuevo hostname elegido es [$new_hostname]

Escribe otro si quieres cambiarla.
Despues pulsa [ENTER] [$new_hostname]:  "    

read -s nuevohost
nuevohost="${nuevohost:-$new_hostname}"

if [ -z "$nuevohost" ]
then
    conf_hostname=false
else
    conf_hostname=true
fi

if [ "$conf_hostname" = true ]; then
clear

echo -n "-------------------------------------
CAMBIANDO EL NOMBRE DE HOST      
-------------------------------------"
echo " "    
sudo cp /etc/hosts /etc/hosts.old
sudo sed -i "s/$hostname/$nuevohost/g" /etc/hosts    

sudo cp /etc/hostname /etc/hostname.old
sudo sed -i "s/$hostname/$nuevohost/g" /etc/hostname

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'
clear
echo -n "-------------------------------------
NOMBRE DE HOST CAMBIADO      
-------------------------------------"
sleep 3

#1

else

clear
echo -n "-------------------------------------
    NO SE HAN REALIZADO CAMBIOS       
-------------------------------------"
sleep 3

fi
}