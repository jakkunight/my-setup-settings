	# Setups the nodejs/expo/git basic enviroment:
	echo "    Insatalling git, curl, wget, sqlite and nodejs..."
	apt install git curl wget sqlite3 nodejs -y
	# Upgrades npm:
	echo "    Installing npm..."
	curl -qL https://www.npmjs.com/install.sh | sh
	# Installs Expo and yarn
	echo "    Installing Expo and yarn..."
	npm i -g expo-cli eas-cli nodemon yarn -y

	# Installs tmux (optional):
	echo "    Installing tmux..."
	apt install tmux -y
	
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
	apt install mariadb -y

	# Mounts storage and access to downloads dir:
	echo "    Mounting Termux storage system..."
	termux-setup-storage

	# Installs screenfetch for tunning the enviroment:
	echo "    Installing screenfetch..."
	apt install screenfetch -y

	# Installs htop for control how much RAM are we consuming:
	echo "    Installing htop..."
	apt install htop -y
