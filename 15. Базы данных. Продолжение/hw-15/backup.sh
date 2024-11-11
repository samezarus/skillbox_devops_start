#!/bin/bash

clear


function delete(){
    # Функция удаления файла

    # Целевой файл (абсолютный путь)
    source=$1

    # Если файл
    if [ -f "$source" ]; then
        rm -f "$source"
        # Какое-то логирование ...
    fi
}


function chek_for_delete(){
    # Функция проверяет дату создания файла с датой нижнего предела, 
    # если предел привышен, то файл удаляется

    # Целевой файл (абсолютный путь)
    source=$1

    # Кол-во часов, после которого следует удалить файл
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
            # Какое-то логирование ...
        fi
    fi
}


# Задаём, создаём/пересоздаём каталог(в контексте пользователя под которым выполняется скрипт) 
# для хранеия бэкапов
backup_folder=~/backups/mysql
mkdir -p $backup_folder

# Формирование имени будующего архтва/бэкапа/дампа
timestamp=$(date "+%Y-%m-%d_%H:%M:%S")
arc=$backup_folder/$timestamp.sql.lzma

# Имя пользователя БД (подразумеваем, что пароль не задан)
user=root
# user=sameza

# Предел удаления файлов в часах
hour_limit=168


# Удаляем файлы, если дата создания превышает 'hour_limit'
for name in $(ls $backup_folder); do
    # Абсолютный путь к файду
    full_name="$backup_folder/$name"

    # Проверяем, стоит ли удалить файл
    chek_for_delete $full_name $hour_limit        
done

# Если демон "mysql" не запущен, то "падаем"
if [ "$(systemctl is-active mysql)" != "active" ]; then
    # Какое-то логирование ...
    exit 1
fi 

# Процесс бэкапа всего содержимого
mysqldump \
    -u $user \
    --all-databases \
    --events \
    --ignore-table=mysql.event \
    --extended-insert \
    --add-drop-database \
    --disable-keys \
    --flush-privileges \
    --quick \
    --routines \
    --triggers \
    | lzma > $arc