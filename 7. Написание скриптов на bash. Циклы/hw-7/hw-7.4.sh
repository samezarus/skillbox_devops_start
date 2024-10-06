#!/bin/bash

# Напишите скрипт, который после запуска должен начать создавать папки в 
# директории /tmp, имена которых должны формироваться по шаблону: directory-YYYYMMDD_HHMM. 
# Папки должны создаваться раз в семь минут, скрипт должен закончиться после того, как создаст минимум семь папок.

to_dir='/tmp'

folder_count=0
max_folder_count=7

sleep_step=1m

while [ $folder_count -ne $max_folder_count ]
do
    new_dir=$to_dir/$(date +'%Y%m%d-%H%M')
    echo "Create folder: "$new_dir

    mkdir $new_dir

    folder_count=$(( $folder_count+1 ))

    sleep $sleep_step
done

