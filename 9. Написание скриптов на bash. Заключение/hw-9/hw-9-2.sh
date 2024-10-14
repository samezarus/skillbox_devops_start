#!/bin/bash

# Что нужно сделать
# Как мы уже отмечали, программа rm не даёт права на ошибку и не поддерживает 
# механизма на случай, если вы ошиблись или передумали удалять файл. Давайте 
# это исправим. Напишите скрипт под названием delete, который будет вместо 
# удаления файла сжимать его (можно выбрать алгоритм gzip или lzma) и 
# перемещать в папку /home/username/TRASH.

# Что оценивается
# Каждый раз при запуске скрипт должен просматривать папку TRASH и удалять 
# из неё файлы старше 48 часов.

# Дополнительное задание.
# Сделайте так, чтобы наш скрипт delete поддерживал не только удаление 
# файлов, но и удаление директорий.


##############################################################################

function arc(){
    # Функция архивирования файла/каталога

    # Целевой файл/каталог (абсолютный путь)
    source=$1

    # Имя архива (абсолютный путь)
    destination=$2

    # Если переданные параметры не пусты
    if [ ! -z $source -a ! -z $destination ]; then
        # Имя файла/каталога (из абсолютного)
        title=${source##*/}

        # Если файл, отсекаем расширение
        if [ -f "$source" ]; then
            title=${title%%.*}
        fi

        # Задаём абсолютный путь будущего архива
        full_name=$destination/$title.tar.gz

        # Сжатие
        tar -zcf "$full_name" "$source"
    else
        echo "В функцию 'arc' не переданы нужные параметры. Пример: arc <файл/каталог> <имя архива>"
    fi
}


function delete(){
    # Функция удаления файла/каталога

    # Целевой файл/каталог (абсолютный путь)
    source=$1

    # Если переданный параметр не пуст
    if [ ! -z $source ]; then
        #   Если файл
        if [ -f "$source" ]; then
            rm -f "$source"
        #   Если каталог(удаляем рекурсивно)
        elif [ -d "$source" ]; then
            rm -r -f "$source"
        fi
    else
        echo "В функцию 'delete' не передан нужный параметр. Пример: delete <файл/каталог>"
    fi
}


function get_unix_time(){
    # Функция получает unix-время создания файла/каталога 

    # Целевой файл/каталог (абсолютный путь)
    source=$1

    # Если переданный параметр не пуст
    if [ ! -z $source ]; then
        # Склейка из даты и времени
        date_stamp=$(ls -l --time-style=long-iso $source | awk '{ print $6 }')
        time_stamp=$(ls -l --time-style=long-iso $source | awk '{ print $7 }')
        datetime_stamp=$date_stamp"T"$time_stamp":00"
        # echo $datetime_stamp

        result=$(date -d $datetime_stamp +"%s")
        # echo $result

        echo $(expr $result)
    # В функцию не передан нужный параметр
    else
        # echo "В функцию 'get_unix_time' не передан нужный параметр. Пример: get_unix_time <ГГГГ-ММ-ДДТЧЧ:ММ:СС>"
        echo 0
    fi
}

# Задаём имя каталога корзины
trash_dir=~/TRASH

# Создаём каталог корзину
mkdir -p "$trash_dir"

# Имя скрипта
script=$(basename "$0")

# Полный(абсолютный) путь к цели
target=$1



# Если в скрипт не передали параметр, он же полный путь к архиву
if [ -z "${target}" ]; then
    echo "Скрипт ожидает цель для архивирования в виде первого параметра (Пример: ./$script <каталог/файл>)"
# Если переданная цель(файл/каталог) не существует
elif [ ! -e "$target" ]; then
    echo "Файл/каталог '$target' не найден"
# Если прошли плановые проверки
else
    # arc $target $trash_dir

    # delete $target

    # Текущая дата и время в unix-формате 
    unix_datetime_now=$(date +%s%3N)
    # echo "$unix_datetime_now"

    # Отсечка, после которой должны удаляьться файлы-архивы
    limit=172800  # 48 часов в секундах

    for name in $(ls $trash_dir); do
        # Абсолютный путь к файду
        full_name=$trash_dir/$name

        unix_ts_int=$(get_unix_time $full_name)
        echo $unix_ts

        # # Склейка из даты и времени
        # date_stamp=$(ls -l --time-style=long-iso $full_name | awk '{ print $6 }')
        # time_stamp=$(ls -l --time-style=long-iso $full_name | awk '{ print $7 }')
        # datetime_stamp=$date_stamp"T"$time_stamp":00"
        # # echo $datetime_stamp

        # unix_datetime_stamp=$(date -d $datetime_stamp +"%s")
        # # echo $unix_datetime_stamp

    done

    # get_unix_time "2024-10-15T06:41:00" 
    # echo $?


fi
