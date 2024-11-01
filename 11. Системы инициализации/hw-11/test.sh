# ln -s /home/sameza/Downloads/tsetup.5.4.0.tar.xz ./telega.tar.xz
# ln /home/sameza/Downloads/google-chrome-stable_current_amd64.deb ./chrome.deb

clear

my_link=telega.tar.xz
# my_link=chrome.deb


function is_symlink(){
    # Функция определяет, является ли переданный объект симлинком
    
    link=$1

    test $(readlink $link)
}



function get_symlink_parent(){
    # Фунция пытается найти источник/родителя симлинка
    
    link=$1

    if is_symlink "$link"; then
        echo $(readlink "$link" -ef "$target_path")
    fi
}



if is_symlink $my_link; then
    echo "true"
fi

get_symlink_parent $my_link


function hard_links_count(){
    # Функция определяет кол-во хардлинков у файла
    # По мотивам - https://linux.die.net/man/1/stat

    link=$1

    # Переданный объект не найден
    if [ ! -e "$link" ]; then
        echo 0
    else
        echo $(stat -c %h $link)
    fi
}


function list_hard_links(){
    # Фуекция выводи список "родственных" файлов по inode-номеру
    
    link=$1

    if [ $(hard_links_count "$link") -gt 0 ]; then
        # Получаем inode-номер
        inode_number=$(stat -c %i $link)

        # Ищем "родственников" по inode-номеру везде, начиная с корня.
        # Ошибки прав доступа шлём по известному адресу (2>/dev/null)
        find / -inum $inode_number 2>/dev/null
    fi
}



#
# path=$(dirname "$link")



# hard_links_count $my_link
# hard_links_count "/home/sameza/Downloads/google-chrome-stable_current_amd64.deb"

# list_hard_links $my_link
# list_hard_links "/home/sameza/Downloads/google-chrome-stable_current_amd64.deb"
