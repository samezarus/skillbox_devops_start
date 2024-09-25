#!/bin/bash

echo "Скрипт поддерживает следующие команды:"

echo "1 - dns-имям сайта -> ip-адрес"
echo "2 - ping сайта по dns-имени или ip-адресу"

echo ""
read -p "Введите команду: " cmd

case "$cmd" in
    "1")
        read -p "Введите dns-имям сайта: " dns_name
        host "$dns_name"
        ;;
    "2")  
        read -p "Введите dns-имям сайта: " res
        ping -c5 "$res"
        ;;
    *)     
        echo "Команда не поддерживается"
        ;;
esac