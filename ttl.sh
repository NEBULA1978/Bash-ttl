#!/bin/bash

# Verificamos que se haya proporcionado una dirección IP como argumento
if [ $# -eq 0 ]; then
    echo "Debe proporcionar una dirección IP como argumento."
    exit 1
fi

# Asignamos el primer argumento a la variable host
host=$1

# Mostramos un mensaje al usuario
echo "Vamos a analizar la siguiente dirección IP: $host"

# Realizamos un ping al host y guardamos la salida en un archivo
ping -c 1 $host > ping.log

# Buscamos un rango de valores de TTL que corresponde a un sistema operativo Linux
for i in $(seq 60 70); do
    if grep -q "ttl=$i" ping.log; then
        echo "Es un Linux"
        # Salimos del script si encontramos una coincidencia
        exit 0
    fi
done

# Buscamos un rango de valores de TTL que corresponde a un sistema operativo Windows
for i in $(seq 100 200); do
    if grep -q "ttl=$i" ping.log; then
        echo "Es un Windows"
        # Salimos del script si encontramos una coincidencia
        exit 0
    fi
done

# Si no se encontró ninguna coincidencia, mostramos un mensaje de error
echo "No se pudo determinar el sistema operativo."
exit 1


    # Verificamos que se haya proporcionado un argumento al script usando $#. Si no se proporcionó ningún argumento, mostramos un mensaje de error y salimos del script con un código de error (1).
    # Usamos ping -c 1 para realizar un ping al host y obtener una sola respuesta. Esto nos permite evitar que el script se quede esperando por más tiempo del necesario. También corregimos la sintaxis de ping-c a ping -c.
    # Usamos -q con el comando grep para que no se muestre la salida de la coincidencia encontrada. No necesitamos mostrar nada, solo necesitamos saber si hubo una coincidencia o no.
    # Agregamos exit 0 después de mostrar el mensaje de "Es un Linux" o "Es un Windows" para salir del script inmediatamente. Esto se hace para evitar continuar buscando en el archivo ping.log innecesariamente.
    # Agregamos un mensaje de error en caso de que no se encuentre ninguna coincidencia. También salimos del script con un código de error (1).












# # -ping -c 1 www.google.es
# # PING ww.google.es (142.250.184.163)56(84)bytes of data.
# # 64 bytes from mad07s23-in-f3.1e100.net (142.250.184.163):icmp_seq=1
# # ttl=115 time=25.5 ms

# # (ka1i©kali)-[~]
# # -ping -c 1 localhost
# # PING localhost(localhost (:1))56 data bytes
# # 64 bytes from localhost (1):icmp_seq=1 ttl=64 time=0.084 ms
# # localhost ping statistics
# # I
# # 1 packets transmitted,1 received,0%packet loss,time 0ms
# # rtt min/avg/max/mdev=0.084/0.084/0.084/0.000ms

# host=$1
# echo "Vamos a analizar la siguiente direccion IP: $host"
# ping-c 1 $host > ping.log

# for i in $(seq 60 70);do
#   if test $(grep ttl=ping.l
#     echo "Es un Linux"


# fi
# done

# for i in $(seq 100 200);do
#   if test $(grep ttl=$1 ping.log -c) = 1;then
#     echo "Es un Windows"
# fi
# done

# rm ping.log