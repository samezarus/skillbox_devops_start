#!/bin/bash

# Что нужно сделать
# Напишите скрипт для распаковки заархивированных файлов. 
# Скрипт должен обрабатывать архивы в формате .gz, .bz2, .lzma, .zip.

# Не забудьте, что программу unzip вам потребуется установить. 
# В скрипте нужно проверять, установлена ли программа, 
# если нет — выдавать сообщение пользователю.

# Что оценивается
# Скрипт должен принимать в качестве аргумента имя файла и 
# самостоятельно решать, какую программу для распаковки необходимо использовать.

###################################################################################

# Имя скрипта
script=$(basename "$0")

# Полный путь к архиву
arc=$1

# Расширение архтва
ext=$( echo $arc | sed 's/^.*\.//' )

# "Список" поддерживаемых скриптом архиваторов
extensions="gz bz2 lzma zip"


# Функция проверяет входит ли расширение переданного архива в список поддерживаемых
function validate_ext() {  
    for item in $extensions; do
        if [ "$item" = "$ext" ]; then
            echo "0"
            return 0
        fi
    done

    return 1
}

# Тест на присутствие утилиты в системе. Название утилиты передаётся параметром
function check_app(){
    check_item=$1
    type "$check_item" > /dev/null 2>&1
    
    if [ $(echo $?) = 0 ]; then
        echo "0"
        return 0
    else
        return 1
    fi 
}


# Если в скрипт не передали параметр, он же полный путь к архиву
if [ -z "${arc}" ]; then
    echo "Скрипт ожидает имя архива в виде первого параметра (Пример: ./$script <имя архива>)"
# Если переданный путь не существует
elif [ ! -f "$arc" ]; then
    echo "Файл архив '$arc' не найден"
# Если расширнение не входит в список поддерживаемых
elif [ ! $(validate_ext) ]; then
    echo "Расширение '$ext' не поддерживается"
# Если не нашли утилиту unzip в системе
elif [ ! $(check_app "unzip") ]; then
    echo "У вас не установленна утилита 'unzip'. Установка: sudo apt install unzip"
fi


# if [ ! $(check_zip "zip1") ]; then
#     echo "false"
# fi



# if type "zip"; then
#     return 0
# else
#     return 1
# fi

# echo $(validate_ext)


# for x in "item 1" "item2" "item 3" "3" "*"; do
#     echo -n "'$x' is "
#     validate_ext "$x" && echo "valid" || echo "invalid"
# done


# res=$( echo $extensions | grep -q $arc_ext )
# find_ext=$( echo $extensions | grep "$arc_ext" )

# echo $find_ext

# if [ $(echo $extensions | grep "arc_ext") ]; then
#     echo found
# else
#     echo not found
# fi

# print_something () {
#     echo Hello $1
# }

# print_something Mars