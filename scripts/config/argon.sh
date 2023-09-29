#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar eReader ubooquity
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
#source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
#export hostname="$(cat /etc/hostname)"
#export PATH_UBOOQUITY="/opt/ubooquity"
#export ja="default-jdk"
#export un="unzip"
export argononed="true"
. /SHConfig/db/variables.txt
#export eReader="@reboot sleep 180 && cd $PATH_UBOOQUITY && nohup /usr/bin/java -jar $PATH_UBOOQUITY/Ubooquity.jar /opt/ubooquity/Ubooquity.jar --remoteadmin --headless"

#######################################################################
#  COMPROBAR INSTALACION DEL EREADER
########################################################################
install_git() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' git 2>/dev/null \ | grep -q '^.i $';
    then
    clear
echo -ne "-------------------------------------
GIT YA ESTA INSTALADO     
-------------------------------------
"
    else
echo -ne "-------------------------------------
INSTALANDO GIT ESPERE...      
-------------------------------------"
    sudo apt-get install git -y &>/dev/null
    sleep 3 
echo -ne "-------------------------------------
INSTALACION DE GIT FINALIZADA      
-------------------------------------"
    sleep 3
    install_argon
    fi
}  
install_argon() {
    if [ -f /etc/systemd/system/argononed.service ];
    then
    clear
echo -ne "-------------------------------------
ARGONONED YA ESTA INSTALADO     
-------------------------------------"    
    else
echo -ne "-------------------------------------
INSTALANDO ARGONONED ESPERE...      
-------------------------------------
"
    #rm -rf /argonone/*
    #rm -rf /argonone/.*
    git clone https://github.com/proyectopy/argononesp.git /argonone &>/dev/null
    sleep 3
    sudo chown pi:pi /argonone
    sudo chmod -R 755 /argonone
    cd /argonone
    ./install
echo -ne "-------------------------------------
INSTALACION ARGONONE FINALIZADA      
-------------------------------------"
    sleep 3
echo -ne "-------------------------------------
CONFIGURAR TEMPERATURAS/VELOCIDADES    
-------------------------------------"
    sudo chmod +x argonone.sh
    ./argonone.sh
    fi
}  
argon.sh() {
clear
if [ "$argononed" = true ]; then
clear 
echo -ne "--------------------------------------------------
... COMPROBANDO EL ENTORNO PARA LA INSTALACION ...
INSTALAREMOS GIT SI NO ESTA Y CLONAREMOS EL REPO     
--------------------------------------------------"
        install_git 
        install_argon
fi        
}
#clear
#if [ "$argononed" = false ]; then
#clear 
#echo -ne "-------------------------------------
#INSTALANDO ARGONONED ESPERE...      
#-------------------------------------"
#        #install_git 
#        #install_argon
#else
#clear
#echo -ne "-------------------------------------
#ARGONONED YA ESTA INSTALADO     
#-------------------------------------" 
#fi
#        else
#clear
#echo -ne "-------------------------------------
#BORRADO DIRECTORIO /ARGONONE/     
#-------------------------------------"
#
#}
#comprobar     
