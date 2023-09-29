#!/bin/bash

########################################################################
# Script: wifi.sh
# Descripcion: Configurar red wifi
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
. /SHConfig/db/variables.txt
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
#default_ssid="nombre-de-tu-wifi"
#default_psk="password-de-tu-wifi"
#default_key="WPA-PSK"
## WPA/WPA2 TKIP/AES
#ip=192.168.1.105
#mask=255.255.255.0
###################################################
# CONFIRMAR CONFIGURACION DE UNA IP FIJA (OK)  
###################################################
wifi.sh (){
    clear
    clave=$(echo $ssidkey | openssl enc -d -des3 -base64 -pass pass:Descifrando -pbkdf2)
    echo $clave
    echo ""
    echo -ne "Quieres Activar el WIFI de tu Raspberry: [$default] "
    read network
    network="${network:-$default}"
    echo ""
    echo -ne "Has elegido que $network quieres configurar la red"
    sleep 3

    if [ $network != $default ]
        then

            conf_wifi=false
            #sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            #source /home/pi/.configuracion/.scripts/.menus/menuredes.sh

        else
        
            conf_wifi=true
            conf_wifi
    fi
}
###################################################
# CONFIGURACION DE LA CONEXION DE RED (OK)  
###################################################
function conf_wifi (){
    if [ "$conf_wifi" = true ]; then

        clear

        
        ###################################################
        #            OBTENER NOMBRE DEL WIFI              #
        ###################################################
        clear
        msg_wifissid
        echo ""
        echo -ne "El valor por defecto es $ssidwifi. Introduce el nombre de la red"
        echo ""
        echo -ne "Escribe el nombre de la red y pulsa [ENTER]:"
        read -s ssid
        # : ${ssid:=$ssidwifi}
        ssid="${ssid:-$ssidwifi}"
        
        sleep 3

        # Comprueba que se haya introducido algun dato
        while [ "$ssid" = "" ]
        do
            # read ssid
            clear
           echo ""
            echo -ne "No se puede quedar vacio"
            echo ""
            echo -ne "El valor por defecto es $ssidwifi."
            echo ""
            echo -ne "Introduce el nombre de tu red. y pulsa [ENTER]:"
            read ssid
        done

        ###################################################
        #              OBTENER LA CLAVE WIFI              #
        ###################################################

        
        clear
        echo ""
        echo -ne "El valor que introdujuste es $clave."
        echo ""
        echo -ne "Escribe la clave de tu WiFi si no es correcta y pulsa [ENTER]:" 
        read -s psk
        # : ${psk:=$clave}
        psk="${psk:-$clave}"
        

        while [ "$psk" = "" ]
        do
            # read psk
            clear
            msg_error
            echo ""
            echo -ne "No se puede quedar vacio"
            echo ""
            echo -ne "El valor por defecto es $clave."
            echo ""
            echo -ne "Introduce la clave WiFi. y pulsa [ENTER]:" 
            read psk
        done
        sleep 3
        clear
echo -ne "-----------------------------------------
ESTAMOS CONFIGURANDO
-----------------------------------------"
        sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bkp
        sudo chmod 777 /etc/wpa_supplicant/wpa_supplicant.conf

        #modifica el archivo /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "country=ES" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo " " >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "ssid=\"$ssid"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "scan_ssid=1" >> /etc/wpa_supplicant/wpa_supplicant.conf 
        sudo echo "psk=\"$psk"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "key_mgmt=WPA-PSK" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

        sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
        
        sudo cp /etc/network/interfaces /etc/network/interfaces.bkp
        sudo chmod 777 /etc/network/interfaces

        # Modifica el archivo /etc/network/interfaces
        
        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface eth0" >> /etc/network/interfaces
        sudo echo "auto etho" >> /etc/network/interfaces
        sudo echo "iface eth0 inet static" >> /etc/network/interfaces 
        sudo echo "address $default_ip" >> /etc/network/interfaces
        sudo echo "netmask 255.255.255.0" >> /etc/network/interfaces

        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface WiFi" >> /etc/network/interfaces
        sudo echo "etc/network/interfaces" >> /etc/network/interfaces
        sudo echo "allow-hotplug wlan0" >> /etc/network/interfaces 
        sudo echo "wpa-ssid \"$ssid"\" >> /etc/network/interfaces
        sudo echo "wpa-psk \"$psk"\" >> /etc/network/interfaces

        sudo chmod 644 /etc/network/interfaces
        sleep 3
        clear
echo -ne "-----------------------------------------
WIFI ACTIVADO Y CONFIGURADO CORRECTAMENTE
PARA QUE FUNCIONE CORRECTAMENTE REINICIA
-----------------------------------------"
else

echo -ne "-----------------------------------------
NO SE HAN REALIZADO CAMBIOS
-----------------------------------------"
    fi
        }

