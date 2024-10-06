#!/bin/bash

read -p "Введите первое число: " x
read -p "Введите второе число: " y
read -p "Укажите символ операции ( + | - | * | / | ** ): " operator

case "$operator" in
    "+")
        echo "$x + $y ="  $(expr $x + $y) 
        ;;
    "-")  
        echo "$x - $y ="  $(expr $x - $y) 
        ;;
    "*")  
        echo "$x * $y ="  $(expr $x \* $y) 
        ;;
    "/")  
        if [ $y -gt 0 ]; then 
            echo "$x / $y =" $(expr $x / $y).$(expr $x % $y)
        else
            echo "Делить на ноль запрещено"
        fi
        ;;
    "**") 
        echo "$x ** $y =" $(($x**$y))
        ;;
    *)     
        echo "Команда не поддерживается"
        ;;
esac