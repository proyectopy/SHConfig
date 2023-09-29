#!/bin/bash

########################################################################
# Script: duckdns.sh
# Descripcion: Configurar el DND dinamico con DuckDNS
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
export domain="proyectopy" 
export token="0eb93ffb-ff85-4451-a921-f632039e97ff"
export duckdns="*/2 * * * * /home/pi/.configuracion/.scripts/.duckdns/duckdns >/dev/null 2>&1"
########################################################################
###################################################
#        OBTENER LA VARIABLE HOSTNAME (OK)   
###################################################
duckdns.org.sh (){
    
    msg_duck
    echo ""
    echo -ne " ${F_VDOBLE}Quieres Configurar DuckDns [Si/No]: [$default] "
    read respuesta
    respuesta="${respuesta:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $respuesta quieres configurar DuckDns"
    sleep 3
    if [ $respuesta != $default ]
        then
            conf_duckdns=false
            clear
            msg_sincambios
            sleep 3
            sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            
        else
            conf_duckdns=true
            conf_duckdns

    fi    
   
}
####################################################
#            INSTALAR SCRIPT PARA DUCKDNS        
####################################################
function conf_duckdns (){        
        
        clear
        configurando_msg
        msg_duck
        msg_espere

        sleep 3
        sudo mkdir /home/pi/.configuracion/.scripts/.duckdns
        sudo mkdir /home/pi/.configuracion/.scripts/.duckdns/.logs
        sudo chown -R $USER:$USER /home/pi/.configuracion/.scripts/.duckdns
        sudo chmod -R 777 /home/pi/.configuracion/.scripts/.duckdns/
        sudo touch /home/pi/.configuracion/.scripts/.duckdns/duckdns
        sudo chown -R $USER:$USER /home/pi/.configuracion/.scripts/.duckdns/duckdns
        sudo chmod -R 777 /home/pi/.configuracion/.scripts/.duckdns/duckdns
        #!/bin/bash
        echo "#!/bin/bash">> /home/pi/.configuracion/.scripts/.duckdns/duckdns
        echo "#">> /home/pi/.configuracion/.scripts/.duckdns/duckdns
        echo "# Archivo creado desde el menu Redes">> /home/pi/.configuracion/.scripts/.duckdns/duckdns
        echo echo url="\"https://www.duckdns.org/update?domains=$domain&token=$token&ip=\" | curl -k -o /home/pi/.configuracion/.scripts/.duckdns/.logs/duck.log -K -" >> /home/pi/.configuracion/.scripts/.duckdns/duckdns


        (crontab -u pi -l; echo "$duckdns" ) | crontab -u pi -
        
        source /home/pi/.configuracion/.scripts/.duckdns/duckdns

        clear
        msg_duck
        msg_instalado
}
duckdns