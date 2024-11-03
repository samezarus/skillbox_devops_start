#!/bin/bash


function delete(){
    # Функция удаления файла/каталога

    # Целевой файл/каталог (абсолютный путь)
    source=$1

    # Если входной параметр не пуст
    if [ ! -z $source ]; then
        #   Если файл
        if [ -f "$source" ]; then
            rm -f "$source"
        fi
    fi
}


function chek_for_delete(){
    # Функция проверяет дату создания файла с датой нижнего предела, 
    # если предел привышен, то файл удаляется

    # Целевой файл (абсолютный путь)
    source=$1

    # Дата предела, после которого следует удалить файл
    limit=$2

    # Если входные параметры не пусты
    if [ ! -z $source -a ! -z $limit ]; then

        # Склейка из даты и времени создания файла (в unix-время)
        date_stamp=$(ls -l --time-style=long-iso $source | awk '{ print $6 }')
        time_stamp=$(ls -l --time-style=long-iso $source | awk '{ print $7 }')
        datetime_stamp=$(date --date="$date_stamp $time_stamp" +"%s")

        # Получение предела, перед которым файл должен быть удалён (в формате unix-времени)
        limit_date=$(date --date="$(date '+%Y-%m-%d %H:%M') $limit hour ago" +"%s")

        # Если дата создания файла старее предела, то удаляем файл
        if [ $limit_date -gt $datetime_stamp ]; then
            delete $source
        fi
    fi
}


# Задаём имя каталога корзины
trash_dir=/home/sameza/TRASH

# Предел удаления файлов в часах
hour_limit=24


if [ -d $trash_dir ]; then
    # Удаляем файлы, если дата создания превышает 'hour_limit'
    for name in $(ls $trash_dir); do
        # Абсолютный путь к файду
        full_name="$trash_dir/$name"

        # Проверяем, стоит ли удалить файл
        chek_for_delete $full_name $hour_limit        
    done
fi
