#!/bin/bash

info(){
    echo -e "\e[1mИнформация о Системе\e[0m"
    echo "--------------------"

    distro=$(grep '^NAME=' /etc/os-release | cut -d= -f2 | tr -d '""')

    kernel=$(uname -r)

    packages=$(xbps-query -l | wc -l)

    printf "Дистрибутив : %s\n" "$distro"
    printf "Ядро        : %s\n" "$kernel"
    printf "Пакеты      : %s\n" "$packages"
    echo
    echo "Репозитории:"

    grep -h '^repository=' /etc/xbps.d/*.conf 2>/dev/null \
    | cut -d= -f2 \
    | sed 's/^/ [*] /'
}

update() {
    echo -e "\e[1mСинхронизация репозиториев\e[0m"
    echo
    sudo xbps-install -S
    echo
    echo -e "\e[1mОбновление пакетов\e[0m"
    echo
    sudo xbps-install -u
    echo
    echo -e "\e[1mПакеты обновлены или обновлений нет\e[0m"
    echo
    sudo xbps-remove -o
    echo
    echo -e "\e[1mГотово!\e[0m"
}

case "$1" in
    info)
        info
        ;;

    update)
        update
        ;;

    *)
        echo "Доступные команды: vh {info|update}"
        ;;

esac
