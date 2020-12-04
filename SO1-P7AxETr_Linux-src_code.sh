#!/bin/bash

# FUNCIONES
function esPalindromo(){
        # SI: el primer parámetro es vacío
        if [ -z $1  ]
                # ENTONCES: es vacío
                then echo "La cadena esta vacia"
        else
                # SI NO:

                # CONTENIDO
                cont=$1

                # TAMAÑO DEL CONTENIDO
                length=${#cont}

                # PUNTO MEDIO
                medio=$(( length / 2 ))

                # CONTADOR DE POSICIÓN ACTUAL
                i=0

                # MIENTRAS: el char siguiente por el principio…
                # … coincida con el siguiente por el final
                # Y: la posición actual no sea ya el punto medio
                # ENTONCES: pasa al siguiente char (posición actual++)
                while [[ "${cont:i:1}" == "${cont:length-1-i:1}" && $i != $medio ]]
                do
                        (( i++ ))
                done

                # SI: La posición actual es el punto medio…
                # … es porque no ha saltado hasta el final
                if [[ $i == $medio ]]
                then
                        # ENTONCES: es un palíndromo
                        echo "$cont es un palíndromo."
                else
                        # SI NO: no es un palíndromo
                        echo "$cont no es un palíndromo."
                fi
        fi
}

function divisible() {
        # NÚMERO
        echo "Introduce un número y pulsa retorno [⌅]:"
        read num

        # RECORREMOS: divisor a divisor del 1 al 9
        for i in {1..9}
        do
                # SI: el resto de la división del número por el divisor actual es 0
                if (( num % i == 0 ))
                then
                        # ENTONCES: el número es divisible por el divisor actual
                        echo "→ $num es divisible por $i"
                fi
        done
}

function permisos(){
        # PERMISO DE ESCRITURA (w)
        escrit=0

        # EXISTE
        existe=0

        # NÚMERO DE PARÁMETROS (elementos)
        elem=$#

        # RECORREMOS: elemento a elemento
        for (( i=1; i<=elem; i++ ))
        do
                # SI: existe — ENTONCES: existe uno más de los que ya existían
                # Y SI: tiene permiso w — ENTONCES: tiene permiso de escritura…
                # … uno más de los que ya tenían

                # EXISTE && { ESCRIT && ESCRIT++; EXISTE++; }
                [[ -e $1 ]] && { [[ -w $1 ]] && (( escrit++ )); (( existe++ )); }

                # Pasamos al siguiente
                shift
        done

        echo "Existen $existe ficheros de $elem parámetros, de los cuales, con permiso de escritura, hay $escrit."

}

# FLUJO PRINCIPAL DE INSTRUCCIONES
# SI: no hay 3 parámetros
if [ $# -lt 3 ]
then
        # ENTONCES: hay un error en la entrada
        echo "Error de sintaxis"
else
        # SI NO:

        while
                # MOSTRAMOS: el menú
                echo "Menú"
                echo -e "\t[P] Palindromo"
                echo -e "\t[D] Divisores"
                echo -e "\t[R] Resumenes de argumentos de entrada"
                echo -e "\t[F] Fin"
                read op

                # El estado de las operaciones debería ser correcto,
                # ahora dependerá de
                # SI: la entrada es diferente a "f"
                # O SI: la entrada es diferente a "F"
                # que se siga en el bucle while
                [[ $op != "f" || $op != "F" ]]
        do
                # SI: entramos en el bucle
                # ENTONCES: vemos la opción que se ha marcado
                case $op in
                        P|p) esPalindromo $1  ;;

                        D|d) divisible ;;

                        R|r) permisos $* ;;

                        F|f)
                                echo "Fin de programa."
                                exit ;;

                        *) echo "Opcion incorrecta" ;;
                esac
        done
fi

# Proyecto disponible en: http://gh.thisisadot.me/SO1-P7AxETr_Linux-All
# (c) Agustín S., Sara C., J. Yuri D.