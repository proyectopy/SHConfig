#!/bin/bash

########################################################################
# Script:timezone.sh
# Descripcion: Configurar la zona horaria y el idioma
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
#espana="Vamos a instalar la zona horaria"
#otra="Has elegido la zona horaria por defecto"
#error="Escribe un formato correcto por ejemplo Europe/Paris"
#pregunta="¿Que timezone quieres para tu Raspberry?"
#tiempo=10    
#madrid="Europe/Madrid"
#OBLIGATORIO='/'
default="Si"
. /SHConfig/db/variables.txt
###################################################
#           OBTENER LA VARIABLE TIMEZONE  (OK)     
###################################################
timezone.sh(){


    clear
echo ""
echo -ne " ${F_VDOBLE}Quieres Configurar la zona Horaria (Recomendado) [Si/No]: [$default] "
    read tz
    tz="${tz:-$default}"

echo ""
echo -ne "Has elegido que $tz quieres configurar la Zona Horaria"
    sleep 3
    if [ $tz != $default ]
        then
            conf_timezone=false
        else

clear
echo ""
echo -ne "La zona horaria que elegiste es [$default_madrid]

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER] [$default_madrid]: "

            read tz 
            tz=${tz:-$default_madrid}
            #if [ "$fname" = "a.txt" -o "$fname" = "c.txt" ]
            #[ "$tz" = "$default_madrid" ]
            #[ "$fname" = "a.txt" ] || [ "$fname" = "c.txt" ]
            if [[ "$tz" == *"/"* ]]
            then
                conf_timezone=true
                conf_timezone  
            else
                conf_timezone=false
echo -ne "Escribe un formato correcto por ejemplo Europe/Paris
corrige el error y despues pulsa [ENTER] [$default_madrid]: "
echo ""
            fi

            #if [ "$conf_hostname" = true ]; then
            #clear

            #if [[ "$tz" == *"/"* ]]; 
            #    then #comprueba que esista la barra
            #        if  [ "$tz" = "$default_madrid" ] ;then #comprueba que sea la respuesta por defecto
            #            echo -ne "Has elegido la zona horaria por defecto $default_madrid" #imprime el mensaje de elegido por defecto
            #            conf_timezone=true
            #            #echo "$conf_timezone"
            #            conf_timezone
            #            else
            #                if  [ "$tz" = "$tz" ] ;then #comprueba que NO sea la respuesta por defecto
            #                echo -ne "\nHas elegido la zona horaria por defecto $tz\n" #imprime el mensaje de elegido por defecto
            #                conf_timezone=true
            #                #echo "$conf_timezone"
            #                conf_timezone
            #                fi
            #            fi    
            #    else 
            #            conf_timezone=false
            #            #msg_tz
            #            echo -ne "Escribe un formato correcto por ejemplo Europe/Paris
            #            corrige el error y despues pulsa [ENTER] [$default_madrid]: "
            #            sleep 3
            #fi
            # cuestion    
    fi                   
}
###################################################
#   CONFIGURAR EL TIMEZONE O ZONA HORARIA  (OK)     
###################################################
conf_timezone (){
    if [ "$conf_timezone" = true ]; then
        
        clear

echo -ne "-------------------------------------
ESTAMOS CONFIGURANDO LA ZONA HORARIA
Y EL IDIOMA.  ESPERE POR FAVOR     
-------------------------------------"
echo " "
        #modifica tu timezone donde pone Europe/Madrid en la siguente linea#
        sudo timedatectl set-timezone $tz --no-pager
        # --help
        # timedatectl 

        #modifica tu locale descomentando es_ES.UTF-8  
        sudo sed -i 's/^# *\(es_ES.UTF-8\)/\1/' /etc/locale.gen && sudo locale-gen &>/dev/null
        #modifica el archivo hostname cambiando el nuevo nombre
        sudo sed -i "s/LANG=en_GB.UTF-8/LANG=es_ES.UTF-8/g" /etc/default/locale
        # sudo dpkg-reconfigure locales 
        sudo update-locale 
        clear
echo -ne "-------------------------------------
CONFIGURADO CORRECTAMENTE     
-------------------------------------"
echo " "
        sleep 2
        clear
    else

    clear
echo -ne "-------------------------------------
SIN CAMBIOS  
-------------------------------------"
echo " "
    sleep 3
    fi
}