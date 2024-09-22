#!/bin/bash

read -p "Введите первое число: " x
read -p "Введите второе число: " y
read -p "Укажите символ операции ( + | - | * | / | ** | % ): " operator

zero=0

# case "$operator" in
#     "+" )  echo "$x + $y ="  $(expr $x + $y) ;;
#     "-" )  echo "$x - $y ="  $(expr $x - $y) ;;
#     "*" )  echo "$x * $y ="  $(expr $x \* $y) ;;
#     "/" )  echo "$x / $y ="  $(expr $x / $y) ;;
#     "**" ) echo "$x ** $y =" $(($x**$y));;
#     "%" )  echo "$x % $y ="  $(expr $x % $y) ;;
#     *)     echo "Команда не поддерживается"
# esac


if [$y -gt $zero]; then 
    echo "asd"
fi

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
        if [$y -gt $zero]; then echo "asd"; fi
        ;;
    "**") 
        echo "$x ** $y =" $(($x**$y))
        ;;
    "%")  
        echo "$x % $y ="  $(expr $x % $y) 
        ;;
    *)     
        echo "Команда не поддерживается"
        ;;
esac