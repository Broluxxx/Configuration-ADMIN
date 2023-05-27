#!/bin/bash
# Pensez à vérifier que vous disposez bien des packages nécessaire

read -p "Connexion UDP ou TCP ? (U/T): " connexion

if [ "$connexion" == "T" ]; then
    read -p "Veuillez indiquer le numéro de port à activer : " valeur
    echo "Activation du port : $valeur"
    iptables -A INPUT -p tcp --dport $valeur -j ACCEPT

    read -p "Voulez-vous vérifier la règle du pare-feu ? (Oui/Non): " reponse
    if [ "$reponse" == "Oui" ]; then
        iptables -L INPUT --line-numbers | grep "tcp dpt:$valeur"
    else
        exit 0
    fi
elif [ "$connexion" == "U" ]; then
    read -p "Veuillez indiquer le numéro de port à activer : " valeur
    echo "Activation du port : $valeur"
    iptables -A INPUT -p udp --dport $valeur -j ACCEPT

    read -p "Voulez-vous vérifier la règle du pare-feu ? (Oui/Non): " reponse
    if [ "$reponse" == "Oui" ]; then
        iptables -L INPUT --line-numbers | grep "udp dpt:$valeur"
    else
        exit 0
    fi
else
    exit 0
fi