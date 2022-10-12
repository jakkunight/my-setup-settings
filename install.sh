#!/bin/bash
# Script to mount your setup:
echo "----------------------------------------------------------------------------------------------------"
echo "This script will mount a setup able to develop almost everything you want."
echo "The main tools are intended to use with JAVASCRIPT!!!"
echo "If you want to install another tools for other development setups, you'll be asked for some of them."
echo "Author: Jakku Night (aka @jakkunight on GitHub and @jakku_night on XDA Developers)"
echo "----------------------------------------------------------------------------------------------------"
echo "Upgrading your system..."
sudo apt update -y
sudo apt upgrade -y
echo "System up to date."
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "Installing git, wget and curl..."
sudo apt install git wget curl -y
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing tmux..."
sudo apt install tmux -y
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing mariadb..."
sudo apt install mariadb-server -y
sudo apt install mariadb-client -y
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing nodejs..."
sudo apt install nodejs -y
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing yarn..."
sudo apt install yarnpkg
echo "-----------------------------------------------------------------------------------------------------"
echo "Do you want to download and install npm? [y/N]"
read op
if [[ $op == 'y' || $op == 'Y' ]]; then
	echo "Installing npm..."
	sudo curl -qL https://www.npmjs.com/install.sh | sudo sh
else
	echo "Skipping..."
fi
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing nnn..."
sudo apt install nnn -y
echo "-----------------------------------------------------------------------------------------------------"
echo "Do you want to install C/C++ development tools? [Y/n]"
read op
if [[ $op == 'n' || $op == 'N' ]]; then
	echo "Skipping..."
else
	echo "Installing gcc, g++, make, build-essentials, cmake and clang..."
	sudo apt install gcc g++ make build-essential cmake clang -y
fi
echo "-----------------------------------------------------------------------------------------------------"
echo "Do you want to install the Python modules manager? [Y/n]"
read op
if [[ $op == 'n' || $op == 'N' ]]; then
	echo "Skipping..."
else
	echo "Installing pip..."
	sudo apt install pip -y
fi
echo "------------------------------------------------------------------------------------------------------"
echo "Do you want to install Java tools? [y/N]"
read op
if [[ $op == 'y' || $op == 'Y' ]]; then
	echo "Installing openjdk and openjre..."
	sudo apt install default-jdk -y
else
	echo "Skipping..."
fi
echo "-----------------------------------------------------------------------------------------------------"
echo "Do you want to install micro? [Y/n]"
read op
if [[ $op == 'n' || $op == 'N' ]]; then
	echo "Skipping..."
else
	echo "Installing micro..."
	sudo apt install micro -y
	echo "Adding the SKT (Sketch) Language definition and darknight theme..."
	cp -f ./darknight.micro ~/.config/micro/colorschemes
	mkdir ~/.config/micro/syntax
	cp -f ./sketch.yaml ~/.config/micro/syntax
fi
echo "-----------------------------------------------------------------------------------------------------"
echo "Installing micro plugins..."
micro -plugin install bookmark
micro -plugin install quoter
micro -plugin install comment
micro -plugin install snippets
micro -plugin install filemanager
echo "------------------------------------------------------------------------------------------------------"
echo "Configuring nano..."
mkdir -f ~/.nano
sudo cp -f ./.nanorc ~/.nano
sudo cp -f ./.nanorc ~
sudo git clone https://github.com/jakkunight/nanorc ~/.nano/nanorc
echo "-------------------------------------------------------------------------------------------------------"
echo "Configuring tmux..."
sudo cp -f .tmux.conf ~
echo "-------------------------------------------------------------------------------------------------------"
echo "Select your shell:"
echo "1) Bash (Default)"
echo "2) Zsh"
read shell
if [ $shell == '2' ]; then
	echo "Configuring zsh..."
	echo "Replacing .zshrc file..."
	sudo cp -f .zshrc ~
else
	echo "Configuring bash..."
	echo "Replacing .bashrc file..."
	sudo cp -f .bashrc ~
fi
echo "-------------------------------------------------------------------------------------------------------"
echo "Configuring mariadb..."
sudo service mariadb start
sudo mysql_secure_installation
echo "--------------------------------------------------------------------------------------------------------"
echo "Do you want to add a git user? [y/N]"
read adduser
if [[ $adduser == 'y' || $adduser == 'Y' ]]; then
	echo "Configuring git..."
	echo "Enter your git's username:"
	read name
	git config --global user.name $name
	echo "Insert your git's email:"
	read email
	git config --global user.email $email
else
	echo "Skipping..."
fi
echo "--------------------------------------------------------------------------------------------------------"
echo "Cleaning up..."
sudo apt autoremove -y
echo "--------------------------------------------------------------------------------------------------------"
echo "Al done. Bye!"
