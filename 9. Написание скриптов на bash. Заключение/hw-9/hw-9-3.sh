#!/bin/bash

# Что нужно сделать
# Напишите скрипт, который будет принимать в качестве аргумента имя скрипта и удалять из него все комментарии. 
# Сам скрипт не нужно редактировать, результат работы сохраните в другой файл и выведите пользователю имя нового файла. 

# Не забудьте, что шэбэнг тоже начинается с решётки, но он должен сохраниться.

################################################################


clear


# Имя входного файла
target=$1

# Имя нового файла
new_file=test2.sh


if [ -f "${target}" ]; then

    # Копирование входного файла в новый файл
    sed -n 'p' $target > $new_file

    # Получаем текст со 2-й строки по конец
    # из полученного удаляем все коментарии
    sed -i '2,$ {/^#/d}' $new_file

    echo "Файл '$target' очищен, результат сохранён в '$new_file'"
else
    echo "Файл '$target' не найден"
fi