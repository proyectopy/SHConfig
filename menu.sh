#!/bin/bash

########################################################################
# Script: menu.sh
# Descripcion: Menu de opciones
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
. /SHConfig/imports/imp_config.sh &>/dev/null
#. imports/info_imp.sh
#. imports/scripts_imp.sh
#. imports/serv_imp.sh
#. imports/sist_imp.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
###################################################
#FUNCIONES DEL SCRIPT
###################################################
menu_principal(){
#sleep 5
if [ -f /SHConfig/instalar ] ; then
    sudo rm /SHConfig/instalar
fi
if [ -f /SHConfig/db/variables.txt ] ; then
    sudo rm /SHConfig/db/variables.txt
fi
#sudo rm /SHConfig/instalar
#sudo rm /SHConfig/db/variables.txt
clear
echo "-------------------------------------
MENU DE OPCIONES        
-------------------------------------
Elegir una opcion:
1 - Configuracion inicial
2 - Instalar Servidor
3 - Instalar Aplicaciones 
0 - Salir
-------------------------------------
"
read opcion

case $opcion in

    # Performs the function with the name of the variable passed
    0) clear; exit;;
    #1) clear; variables.sh; upgrade.sh; pikey.sh; rootkey.sh; elhostname.sh; laip.sh; elgateway.sh; elnameserver.sh; expandir.sh; timezone.sh; argon.sh; fin;;
    1) clear; variables.sh; fin;;
    #2) upgrade.sh; curl.sh; git.sh; node.sh; chromium.sh; docker.sh; vscode.sh; ready;;
    #2) sudo chmod +x apps.sh ; source apps.sh;;
    #3) upgrade.sh; ready;;
    *) menu_principal;;

esac
}
menu_principal