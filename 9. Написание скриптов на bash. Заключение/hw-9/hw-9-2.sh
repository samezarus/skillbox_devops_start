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
# Если переданная цель не существует
elif [ ! -e "$target" ]; then
    echo "Файл или каталог '$target' не найден"
# Если прошли плановые проверки
else
    # Имя файла или папки
    name=${target##*/}

    # Если цель файл, отсекаем расширение
    if [ -f "$target" ]; then
        name=${name%%.*}
    fi

    # Задаём имя(абсолютный путь) будующего архива
    arc_name=$trash_dir/$name.tar.gz

    # Сжатие
    tar -zcf "$arc_name" $target

    # Удаление цели
fi
