#!/bin/bash

# Comprobamos si la herramienta nmap está instalada en el sistema
if [ -x "$(command -v nmap)" ]; then
    echo "Nmap está instalado"
else
    read -p "Nmap no está instalado, ¿desea instalarlo? (s/n) " choice
    case "$choice" in 
        s|S ) echo "Instalando nmap..." && sudo apt-get update > /dev/null && sudo apt-get install nmap -y > /dev/null;;
        n|N ) echo "Saliendo..." && exit 1;;
        * ) echo "Opción inválida, saliendo..." && exit 1;;
    esac
fi

ip=$1

ping -c 1 $ip > ping2.log
# Realizamos un ping para determinar si el host está activo y guardamos la salida en un archivo llamado ping2.log

for i in $(seq 60 70); do
    if test $(grep ttl-$i ping2.log -c) = 1; then
        echo "Es un Linux"
    fi
done
# Hacemos un bucle para los posibles valores de ttl para Linux y comprobamos si se encuentra alguno en la salida de ping

for i in $(seq 100 200); do
    if test $(grep ttl-$i ping2.log -c) = 1; then
        echo "Es un Windows"
    fi
done
# Hacemos un bucle para los posibles valores de ttl para Windows y comprobamos si se encuentra alguno en la salida de ping

rm ping2.log
# Borramos el archivo de salida de ping

nmap -p- -sV -sC --open -sS -n -Pn -oN escaneo $ip
# Ejecutamos nmap con diferentes opciones para escanear todos los puertos abiertos en el host y guardar el resultado en un archivo llamado escaneo


# En este script, la opción -x "$(command -v nmap)" se utiliza para verificar si Nmap está instalado y el comando read -p se utiliza para solicitar la entrada del usuario para la instalación. Si el usuario selecciona "s" o "S", el script actualiza el sistema e instala Nmap silenciosamente. Si el usuario selecciona "n" o "N", el script sale con un código de salida de 1. Si el usuario selecciona cualquier otra opción, el script muestra un mensaje de error y sale con un código de salida de 1.
