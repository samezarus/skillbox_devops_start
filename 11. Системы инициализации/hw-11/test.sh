# ln -s /home/sameza/Downloads/tsetup.5.4.0.tar.xz ./telega.tar.xz
# ln /home/sameza/Downloads/google-chrome-stable_current_amd64.deb ./chrome.deb

clear

my_link=chrome.deb

# echo "$(readlink $my_link)"


# if [ -L ${my_link} ]; then
#     echo "$(readlink $my_link)"
# else
#     echo "alarm"
# fi


function is_symlink(){
    test $(readlink $1)
}


function is_hardlink(){
    link=$1
    link_path=${link%%.*}
}


if is_symlink "${my_link}"; then
  echo $my_link is a symlink
else
  echo $my_link is not a symlink
fi



# find ~ -inum 12093735 2>/dev/null

res=$(ls -lai | grep $my_link)

echo $?

echo $res

a="/home/sameza/Downloads/google-chrome-stable_current_amd64.deb"

echo ${a%%.*}