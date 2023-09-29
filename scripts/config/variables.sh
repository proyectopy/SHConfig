#!/bin/bash

########################################################################
# Script: variables.sh
# Descripcion: Cuestionario para obtener la variables
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
Fichero=/SHConfig/db/variables.txt
madrid="Europe/Madrid"
ruta="/argonone"
rutact="/SHConfig/.act/"
################################################### 
###################################################
#FUNCIONES DEL SCRIPT
###################################################
variables.sh(){

if [ -f "$Fichero" ] ; then
    sudo rm "$Fichero"
else
    sudo touch /SHConfig/db/variables.txt
    sudo chmod 777 /SHConfig/db/variables.txt
fi
#sudo chmod 777 /SHConfig/db/variables.txt
#clear
sudo touch /SHConfig/db/variables.txt
sudo chmod 777 /SHConfig/db/variables.txt

clear

echo -n "-------------------------------------
CUESTIONARIO VARIABLES        
-------------------------------------"

echo -ne "\nHacemos unas preguntas para obtener las 
variables que usaremos para configurar la 
Raspberri Pi. \n \n"

read -sp  "Contraseña usuario pi : " pikey
pikey=$(echo $pikey | openssl enc -e -des3 -base64 -pass pass:Descifrando -pbkdf2)
echo ""
sudo echo ""pikey = \"$pikey\">> $Fichero

read -sp "Contraseña usuario root : " rootkey
rootkey=$(echo $rootkey | openssl enc -e -des3 -base64 -pass pass:Descifrando -pbkdf2)
#echo $rootkey
sudo echo ""rootkey = \"$rootkey\">> $Fichero
echo -ne "
Vamos a crear una ruta para el script y los logs de actualizaciones
Por defecto se asigna la ruta $rutact como ruta de instalacion
Pulsa [ENTER] para continuar "
read r_act
r_act="${r_act:=$rutact}"
sudo echo ""r_act = \"$r_act\" >> $Fichero

read -p  "Nuevo hostname para tu Raspberry : " new_hostname
sudo echo new_hostname = \"$new_hostname\" >> $Fichero

read -p  "IP fija para tu Raspberry : " default_ip
sudo echo default_ip = \"$default_ip\" >> $Fichero

read -p  "Puerta de acceso para tu Raspberry : " default_gtw
sudo echo default_gtw = \"$default_gtw\" >> $Fichero

read -p  "Servidor de nombres para tu Raspberry : " default_nmsrv
sudo echo default_nmsrv = \"$default_nmsrv\" >> $Fichero

echo -ne "Por defecto se asigna $madrid como zona horaria,
Usamos [$madrid] como zona horaria,
Pulsa [ENTER] para continuar "
read default_madrid
default_madrid="${default_madrid:=$madrid}"
sudo echo default_madrid = \"$default_madrid\" >> $Fichero

echo -ne "Vamos a crear una ruta por si usas la caja Argon ONE V2
No te preocupes, si no la usas se borrará al final de la instalación 
Pulsa [ENTER] para continuar "
read ex
#ex="${ex:-$default}"
echo -ne "Por defecto se asigna la ruta $ruta como ruta de 
instalacion del script. Usamos [$ruta] para la instalación
Pulsa [ENTER] para continuar "
read -s rutargon
rutaargon="${rutargon:=$ruta}"
sudo echo rutargon = \"$rutargon\" >> $Fichero
sudo mkdir -p /$rutargon
sudo chown pi:pi /$rutargon
sudo chmod -R 755 /$rutargon

echo -ne "Tienes la opcion de configurar el WIFI de tu raspberry
necesitarás introducir algunos datos.
Pulsa [ENTER] para continuar "
read ex
#ex="${ex:-$default}"
read -p  "Introduce el SSID(nombre) de tu red : " ssidwifi
sudo echo ssidwifi = \"$ssidwifi\" >> $Fichero

read -sp  "Introduce la clave de tu red : " ssidkey
ssidkey=$(echo $ssidkey | openssl enc -e -des3 -base64 -pass pass:Descifrando -pbkdf2)
echo ""
sudo echo ""ssidkey = \"$ssidkey\">> $Fichero


#cat $Fichero

}
