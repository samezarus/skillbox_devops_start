#!/bin/bash

# В четвёртом уроке мы написали скрипт, который 
# выводит псевдографическую картинку с фразой. Сделайте так, 
# чтобы этот скрипт завершался, если пользователь вводит quit

#while true
#do
#echo 'Список опций: '
#cat << options
#bunny
#tux
#daemon
#kitty
#vader-cola
#options
#echo
#read -p 'Ваш выбор: ' option
#fortune | cowsay -f $option
#done


while true
do

echo 'Список опций (q/quit для выхода): '

cat << options
bunny
tux
daemon
kitty
vader-cola
options

echo

read -p "Ваш выбор: " option

if [ $option = "q" -o $option = "quit" ]; then
    break
fi 

fortune | cowsay -f $option

done
