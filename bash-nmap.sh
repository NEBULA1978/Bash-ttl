#!/bin/bash

# # Comprobamos si la herramienta nmap está instalada en el sistema
# test -f /usr/bin/nmap

# if [ "$(echo $?)" == "0" ]then
#     echo "Nmap esta instalado"

# else

#     echo "Nmap No esta instalado" && sudp apt update > /dev/null && sudo apt install nmap -y > /dev/null
# fi

# ip=$1

# ping-c 1 $ip > ping2.log

# # Realizamos un ping para determinar si el host está activo y guardamos la salida en un archivo llamado ping2.log

# for i in $(seq 60 70); do
#     if test $(grep ttl-$1 ping2.log -c) = 1; then
#         echo "Es un Linux"
# fi
# done

# for i in $(seq 100 200); do
#     if test $(grep ttl-$1 ping2.log -c) = 1; then
#         echo "Es un Windows"
# fi
# done

# rm ping2.log

# nmap -p- -sV -sC --open -sS -n -Pn -on escaneo

# # Para ejeccutar:
# # chmod +x *.sh
# # ./bash-nmap.sh 192.168.0.3

#!/bin/bash

# Comprobamos si la herramienta nmap está instalada en el sistema
test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ]then
    echo "Nmap está instalado"

else

    echo "Nmap no está instalado" && sudo apt update > /dev/null && sudo apt install nmap -y > /dev/null
    # Si nmap no está instalado, se actualiza el sistema y se instala nmap silenciosamente
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
