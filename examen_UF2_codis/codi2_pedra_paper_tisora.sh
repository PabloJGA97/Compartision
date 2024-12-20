#!/bin/bash

TRIA=""

# [ $OPCIO != "sortir" ] salta un error si no poses la variable entre cometes dobles, preferible usar doble claudator sempre 
while [[ $TRIA != "Sortir" ]]; do
    # Demana a l'usuari que introdueixi la seva elecció
    echo "-escriu 'pedra' per escollir pedra"
    echo "-escriu 'paper' per escollir paper"
    echo "-escriu 'tisora' per escollir tisora"
    echo "-escriu "Sortir" per sortir del programa"
    read -p "quina opcio esculls? " TRIA

    # comprovació cutre per comprovar que la tria estigui escrita tal qual la demanem 
    # per alguna raó del dimoni, en aquest condicional només entra si les comparacions es fan amb ==, no amb !=
    # a mi em fa més sentit amb !=, però no al sistema 
    if [[ $TRIA == "pedra" || $TRIA == "paper" || $TRIA == "tisora" || $TRIA == "Sortir" ]]; then 
        if [ $TRIA == "Sortir" ]; then
            echo "adeu"
            break
        fi

        # Ni aixo tampoc, i era important per assignar cada resposta al numero per després fer els condicionals
        case $TRIA in 
            'pedra')
                TRIA_JUGADOR=0
                ;;
            'paper')
                TRIA_JUGADOR=1
                ;;
            'tisora')
                TRIA_JUGADOR=2
                ;;
        esac

        # generem les opcions de l'ordinador
        # com que això es una operació, havia d'anar amb let o $(()) i jo només hvia usat un doble parèntesi en comptes de dos
        TRIA_PC=$((RANDOM % 3))       

        # xuleta: 0,1,2
        #          pedra, paper, tisora

        # deb
        # echo "El jugador ha triat $TRIA_JUGADOR"
        # echo "El sistema ha triat $TRIA_PC"

        # Determinar el guanyador. 
        # Per entendre-ho, cada numero guanya contra l'anterior i perd contra el següent. ex: el 1 guanya al 0 però perd contra el 2. 
        # el nombre seguent de 2 és 0, i l'anterior de 0 és 2, ja que és una llista limitada de nombres 
        if (( TRIA_JUGADOR == TRIA_PC )); then 
                echo "empat!"
        elif (( $TRIA_JUGADOR == 0 ))  && (( $TRIA_PC == 2 )); then
                echo "Has guanyat! Pedra guanya a la tisora"
        elif (( $TRIA_JUGADOR == 0 )) && (( $TRIA_PC == 1 )); then
                echo "Has perdut! Pedra perd contra paper"
        elif (( $TRIA_JUGADOR == 1 ))  && (( $TRIA_PC == 0 )); then
                echo "Has guanyat! Paper guanya a la pedra"
        elif (( $TRIA_JUGADOR == 1 )) && (( $TRIA_PC == 2 )); then
                echo "Has perdut! Paper perd contra la tisora"
        elif (( $TRIA_JUGADOR == 2 ))  && (( $TRIA_PC == 1 )); then
                echo "Has guanyat! Tisora guanya al paper"
        elif (( $TRIA_JUGADOR == 2 )) && (( $TRIA_PC == 0 )); then
                echo "Has perdut! Tisora perd contra la pedra"
        fi
    else
        echo "opcio no valida"
    fi
done

