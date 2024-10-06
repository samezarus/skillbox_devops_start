#!/bin/bash

# Напишите скрипт, который найдёт и выведет все 
# исполняемые файлы в директории /usr.
 
# В моей системе Kubuntu 24.04 директория "/usr" не содержит исполняемых файлов

for item in `ls /usr/*`; do
    # Проверка что элемент множества/листа является файлом и текущему пользователя есть права на его исполнение
    if [ -f $item ] && [ -x $item ]; then 
        echo “$item”
    fi
done



