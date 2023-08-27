#!/bin/bash

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

function start_nginx_server() {
    echo "Enter the directory to serve files from:"
    read -r directory

    if [ ! -d "$directory" ]; then
        echo -e "\e[91mError: The specified directory does not exist.\e[0m"
        return
    fi

    echo "Enter the port number:"
    read -r port

    sudo pacman -S nginx
    sudo systemctl start nginx
    echo -e "\e[92mNginx server started. Access your files at http://localhost:$port.\e[0m"
    echo "To stop the Nginx server, run: sudo systemctl stop nginx"
}

function start_apache_server() {
    echo "Enter the directory to serve files from:"
    read -r directory

    if [ ! -d "$directory" ]; then
        echo -e "\e[91mError: The specified directory does not exist.\e[0m"
        return
    fi

    echo "Enter the port number:"
    read -r port

    sudo pacman -S apache
    sudo systemctl start httpd
    echo -e "\e[92mApache server started. Access your files at http://localhost:$port.\e[0m"
}

clear  # Clear the console before displaying the menu

check_python

echo -e "\e[96mWelcome to the Professional File Server Script!\e[0m"
echo "Choose a server type:"
echo "1. Python built-in server"
echo "2. Nginx server"
echo "3. Apache server"
echo "4. Quit"

read -r choice

case $choice in
    1)
        start_python_server
        ;;
    2)
        start_nginx_server
        ;;
    3)
        start_apache_server
        ;;
    4)
        echo "Exiting..."
        ;;
    *)
        echo "Invalid choice"
        ;;
esac

exit 0
