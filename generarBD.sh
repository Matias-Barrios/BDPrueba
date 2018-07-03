#!/bin/bash


Cedula_Aleatoria () {
	
	numero="$(Numero_Aleatorio 1 6)$(Numero_Aleatorio 100000 999999)"
	digitos=( $(echo $numero | sed -e 's/\(.\)/\1 /g') )
	digito_verificador=`awk -v digito1="${digitos[0]}"  -v digito2="${digitos[1]}" -v digito3="${digitos[2]}" -v digito4="${digitos[3]}" -v digito5="${digitos[4]}" -v digito6="${digitos[5]}" -v digito7="${digitos[6]}" 'BEGIN { print   ( (digito1 * 8) + (digito2 * 1) + (digito3 * 2) + (digito4 * 3) + (digito5 * 4) + (digito6 * 7) + (digito7 * 6) )    % 10  } ';`
	printf "${numero}${digito_verificador}"
	
}

Numero_Aleatorio() {
    shuf -i $1-$2 -n 1
}

Item_Aleatorio(){
    local arr=( $1 )
    local size=${#arr[@]}
    (( size-- ))
    printf "${arr[$( Numero_Aleatorio 0 $size )]}"

}

lista_nombres=$( cat nombres.txt | tr '\n' ' ' )
lista_apellidos=$( cat apellidos.txt | tr '\n' ' ' )

########################################
## Tabla DOCENTES
########################################
# CREATE TABLE Docentes (

#     CI INT PRIMARY KEY CONSTRAINT CI_valida,
#     nombre varchar(30) NOT NULL CONSTRAINT Nombre_valido,
#     apellido varchar(30) NOT NULL CONSTRAINT Apellido_valido,
#     fecha_Nac DATE NOT NULL CONSTRAINT Fecha_Nac_valida,
#     grado INT CHECK ( grado > 0 AND grado < 8)
# );


echo "CONNECT TO 'matias@172.16.129.130' USER 'XXXUSERNAMEXXX' USING 'XXXPASSWORDXXX';" > 02_ingresar_docentes.sql 
echo -e '\n' >> 02_ingresar_docentes.sql 

i=0;
while [[ $i -lt 1 ]]
do
    echo "INSERT INTO Personas (CI, nombre, apellido, fecha_nac, grado)" >> 02_ingresar_docentes.sql 
    CI=$( Cedula_Aleatoria )
    nombre=$( Item_Aleatorio "$lista_nombres" )
    apellido=$( Item_Aleatorio "$lista_apellidos" )
    numero_dias=$( Numero_Aleatorio 5400 19000 )
    fecha_nac=$( date +%m/%d/%Y --date "$numero_dias days ago" )
    grado=$( Numero_Aleatorio 1 7 )

    echo "VALUES ($CI, \"$nombre\", \"$apellido\", \"$fecha_nac\", \"$grado\" )"  >> 02_ingresar_docentes.sql 
    (( i++ ))
done
########################################
########################################
