#!/bin/bash

# Доработайте приложенный скрипт из 4-го урока так, чтобы 
# он выводил только чётные значения переменной $num
#
# num=0
#while [ $num -lt 10 ] 
#do
#    num=$( expr $num + 1 )
#    echo $num $(fortune)     
#done

num=0

while [ $num -lt 10 ] 
do
    num=$( expr $num + 1 )

    if [ $(($num%2)) -eq 0 ]; then
        echo $num $(fortune)
    fi
done

