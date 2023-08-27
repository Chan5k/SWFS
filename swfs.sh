#!/bin/bash

function check_python() {
    if command -v python3 &> /dev/null; then
        echo -e "\e[92mPython3 is installed.\e[0m"
    else
        echo -e "\e[91mPython3 is not installed. Please install Python3 to use this script.\e[0m"
        echo "You can download and install Python from https://www.python.org/downloads/"
        exit 1
    fi
}

function start_file_server() {
    echo "Enter the directory to serve files from:"
    read -r directory

    if [ ! -d "$directory" ]; then
        echo -e "\e[91mError: The specified directory does not exist.\e[0m"
        return
    fi

    echo "Enter the port number:"
    read -r port

    if ! [[ "$port" =~ ^[0-9]+$ ]]; then
        echo -e "\e[91mError: Port number must be a valid integer.\e[0m"
        return
    fi

    echo "Start the file server in the background? (y/n):"
    read -r background_choice

    if [ "$background_choice" = "y" ] || [ "$background_choice" = "Y" ]; then
        echo -e "\e[92mStarting file server on port $port in the background...\e[0m"
        python3 -m http.server "$port" --directory "$directory" > /dev/null 2>&1 &
        server_pid=$!  # Get the PID of the background process
        echo "File server is running in the background. Use 'kill $server_pid' to end it."
    else
        echo -e "\e[92mStarting file server on port $port...\e[0m"
        python3 -m http.server "$port" --directory "$directory"
    fi
}

clear  # Clear the console before displaying the menu

check_python

echo -e "\e[96mWelcome to SWFS 1.0!\e[0m"
echo "1. Start File Server"
echo "2. Quit"

read -r choice

case $choice in
    1)
        start_file_server
        ;;
    2)
        echo "Exiting..."
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
