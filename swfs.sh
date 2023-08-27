#!/bin/bash

NGINX_PORT=8080
APACHE_PORT=8081

function check_python() {
    if command -v python3 &> /dev/null; then
        echo -e "\e[92mPython3 is installed.\e[0m"
    else
        echo -e "\e[91mPython3 is not installed. Please install Python3 to use this script.\e[0m"
        echo "You can install Python using your package manager. For example, on Arch Linux:"
        echo "sudo pacman -S python"
        exit 1
    fi
}

function start_python_server() {
    echo "Enter the directory to serve files from:"
    read -r directory

    if [ ! -d "$directory" ]; then
        echo -e "\e[91mError: The specified directory does not exist.\e[0m"
        return
    fi

    echo "Enter the port number:"
    read -r port

    python3 -m http.server "$port" --directory "$directory"
}

clear  # Clear the console before displaying the menu

check_python

echo -e "\e[96mWelcome to the Professional File Server Script!\e[0m"
echo "Choose a server type:"
echo "1. Python built-in server"
echo "2. Quit"

read -r choice

case $choice in
    1)
        start_python_server
        ;;
    2)
        echo "Exiting..."
        ;;
    *)
        echo "Invalid choice"
        ;;
esac

exit 0
