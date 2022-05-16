# Script to install all the necesary tools for development
echo "    Read the sript file after running. It will help you."
echo "    Updating your system..."
pkg update -y

# WARNING: ROOT ZONE!!!
# Asks for root and tries to setup your enviroment according to this:
echo "    Are you a ROOT USER (aka: SUPER USER or ADMINISTRATOR) [y|N]?"
read is_rooted
if [ $is_rooted == "y" ] || [ $is_rooted == "Y" ]
then
	pkg install root-repo -y
	pkg install tsu -y
        echo "    You have SUPER USER PERMISIONS NOW! USE IT WISELY!!!"
	echo "    If you have installed Kali NetHunter, want to use it instead Termux? [Y|n]"
	read use_kali
	if [ $use_kali != "n" ] && [ $use_kali != "N" ]
	then
		sudo cp -f ./.zshrc /data/local/nhsystem/kali-arm64/root
		if [ ! -f ~/.bashrc ]
		then
		touch ~/.bashrc
	fi
	echo "sudo /data/data/com.offsec.nethunter/files/scripts/bootkali" >> ~/.bashrc
else
	# Setups the nodejs/expo/git basic enviroment:
	echo "    Insatalling git, curl, wget, sqlite and nodejs..."
	pkg install git curl wget sqlite nodejs-lts -y
	# Upgrades npm:
	echo "    Installing npm..."
	curl -qL https://www.npmjs.com/install.sh | sh
	# Installs Expo and yarn
	echo "    Installing Expo and yarn..."
	npm i -g expo-cli eas-cli nodemon yarn -y

	# Installs tmux (optional):
	echo "    Installing tmux..."
	pkg install tmux -y
	
	# Replaces config files into your root folder:
	echo "    Replacing config files for bash and nano..."
	cp -f ./.bashrc ~
	cp -f ./.nanorc ~

	# Clones the syntax highlighting config files from @scopatz
	echo "    Cloning syntax highlighting config files and creating nano backup dir..."
	cd ~
	if [ ! -d .nano ]
	then
		mkdir .nano
	fi
	cd .nano
	if [ ! -d backups ]
	then
		mkdir backups
	fi
	if [ ! -d nanorc ]
	then
		git clone https://github.com/scopatz/nanorc
	fi

	# Installs mysql:
	echo "    Installing mariadb..."
	pkg install mariadb -y

	# Mounts storage and access to downloads dir:
	echo "    Mounting Termux storage system..."
	termux-setup-storage

	# Installs screenfetch for tunning the enviroment:
	echo "    Installing screenfetch..."
	pkg install screenfetch -y

	# Installs htop for control how much RAM are we consuming:
	echo "    Installing htop..."
	pkg install htop -y
fi

# Exit:
echo "    Bye!"
