#!/bin/bash

validar_usuario() { 
    local usuario=$usuario_script #copiamos el valor de la variable global a una variable local en la funcion, para no modificarla por error. Es simplemente una buena práctica
    if id $usuario; then #Si el usuario existe podemos redireccionar la informacion a &>/dev/null para que no imprima el output por terminal y quede mas bonito
    # los if  siempre evaluan si la condicion es true o false. En este caso, la condicion no es ninguna comparación, sino la ejecución de un comando. 
    # si el comando se ejecuta correctamente (por ejemplo, imprimiendo una linea), evaluará TRUE y entrará en el if. 
        echo "El usuario ya existe" 
        # En este caso el return nos sirve para cambiar la lógica de los exit codes (o codigos de salida), ya que queremos forzar que devuelva TRUE cuando NO exista el usuario
        # recordemos que el exit code 0 indica correcto y 1 indica fallo
        return 1 #FALSE Devuelve error 
    else 
    # en cambio si el comando no imprime nada por pantalla porque no ha encontrado nada, fallará y evaluará FALSE y entrará en el else
        echo "El usuario no existe" 
        # devuelve 0, por lo tanto si no existe el usuario devolverá TRUE 
        # Ten en cuenta que no tiene nada que ver que al principio la condicion fuera false, ya que una cosa es como se evalue al principio y otra cosa diferente es con que valor salga. 
        return 0 #TRUE No devuelve error
    fi
}

crear_usuario() { 
    local usuario=$1 
    # este condicional se puede leer como: "si el string de la variable está vacio..."
    if [ -z "$usuario" ]; then 
        echo "El nombre del usuario no puede estar vacio"
    else  
        sudo useradd "$usuario" && echo "El usuario se ha creado correctamente" 
    fi 
}

salir=false
while [ "$salir" == false ]; 
do 
read -p "Escribe el nombre del usuario que quieres crear: " usuario_script 
# aqui es donde entra en juego el return 0, como hemos indicado que devuelva TRUE si no existe el nombre, entonces si hemos escrito un usuario que no existe, entraria en el if y saldríamos del bucle
if validar_usuario $usuario_script; then 
    echo "Puedes crear el usuario $usuario_script" 
    salir=true #puedo salir del bucle 
else 
    echo "El usuario $usuario_script ya existe" 
fi 
done

if [ "$salir" == true ]; then 
    read -p "¿Quieres crear el usuario $usuario_script? (s/n): " respuesta 
    
    if [ "$respuesta" == "s" ]; then 
    crear_usuario $usuario_script 
    else 
        echo "No se ha creado el usuario $usuario_script"
    fi
fi