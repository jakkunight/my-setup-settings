# Script to install all the necesary tools for development
echo "    Read the sript file after running. It will help you."

# Setups the nodejs/expo/git basic enviroment:
echo "    Updating your system..."
pkg update -y
echo "    Insatalling git, curl and nodejs..."
pkg install git curl nodejs-lts -y
# Upgrades npm:
echo "    Installing npm..."
curl https://npmjs.org/install.sh | sh
# Installs Expo and yarn
echo "    Installing Expo and yarn..."
npm i -g expo-cli eas-cli nodemon yarn -y

# Installs tmux (optional):
echo "    Installing tmux..."
pkg install tmux -y

# Installs vim:
echo "    Installing vim..."
pkg install vim -y

# Clones the config files into your root folder:
echo "    Replacing config files for vim, bash and nano..."
cp -f ./.bashrc ~
cp -f ./.vimrc ~
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
if [ !-d nanorc ]
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

# Exit:
echo "    See the Termux Wiki for more info."
