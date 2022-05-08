# Script to install all the necesary tools for development
echo "Read the sript file after running. It will help you."

# Setups the nodejs/expo/git basic enviroment:
echo "Updating your system..." 
apt update -y
echo "Insatalling git and nodejs..."
apt install git nodejs -y
# Upgrades npm:
echo "Installing npm..."
curl https://npmjs.org/install.sh | sh
# Installs Expo and yarn
echo "Installing Expo and yarn..."
npm i -g expo-cli eas-cli nodemon yarn -y

# Uncomment the following line if nodejs version is not LTS:
#apt install nodejs-lts -y

# Installs tmux (optional):
echo "Installing tmux..."
apt install tmux -y

# Installs vim:
echo "Installing vim..."
apt install vim -y

# Clones the config files into your root folder:
echo "Replacing config files for vim, bash and nano..."
cp ./.bashrc ~
cp ./.vimrc ~
cp ./.nanorc ~

# Installs mysql:
echo "Installing mariadb..."
apt install mariadb -y

# Exit:
echo "See the Termux Wiki for more info."
