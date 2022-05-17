# Setups the nodejs/expo/git basic enviroment:
echo "    Insatalling git, curl, wget, sqlite, nodejs and..."
apt install git curl wget sqlite3 nodejs npm -y
# Upgrades npm:
echo "    Installing npm..."
curl -qL https://www.npmjs.com/install.sh | sh
# Installs Expo and yarn
echo "    Installing Expo and yarn..."
npm i -g expo-cli eas-cli nodemon yarn -y

# Installs tmux (optional):
echo "    Installing tmux..."
apt install tmux -y

# Clones the syntax highlighting config files from @scopatz
echo "    Cloning syntax highlighting config files and creating nano backup dir..."
cd $HOME
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
apt install mariadb-server -y

# Installs htop for control how much RAM are we consuming:
echo "    Installing htop..."
apt install htop -y
