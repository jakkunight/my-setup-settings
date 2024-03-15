#!/usr/bin/bash

# Define shell colors through ANSI ESCAPE SEQUENCES:
green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue="\e[34m"
lgreen="\e[92m"
lyellow="\e[93m"
lblue="\e[94m"
lmagenta="\e[95m"
lcyan="\e[96m"
blink_red="\033[05;31m"
restore="\033[0m"
reset="\e[0m"

# Define status logging functions:
# Shows an error message with colors:
# Usage: error <message>
# Example: error "An unexpected error ocurred."
error(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="Unknwon ERROR. Aborting..."
	fi
	printf "${red}[ERROR]: ${msg}${reset}\n"
}


# Shows an info message with colors:
# Usage: info <message>
# Example: info "Executing command..."
info(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="Nothing to notify."
	fi
	printf "${lcyan}[INFO]: ${msg}${reset}\n"
}

# Shows an success message with colors:
# Usage: success <message>
# Example: success "Done."
success(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="Successfully ended."
	fi
	printf "${lgreen}[SUCCESS]: ${msg}${reset}\n"
}

# Shows an warning message with colors:
# Usage: warning <message>
# Example: warning "An unexpected error ocurred."
warning(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="An error ocurred."
	fi
	printf "${lyellow}[WARNING]: ${msg}${reset}\n"
}

# Asks a "Y/N" question:
# Usage: ask <question> <default>
# Example: ask "Proceed?" "Y"
ask(){
	# Original function by:
	# http://djm.me/ask
	# Modifiyed for personal use by @jakkunight
	while true; do

		if [ "${2:-}" = "Y" ]; then
			prompt="Y/n"
			default=Y
		elif [ "${2:-}" = "N" ]; then
			prompt="y/N"
				default=N
		else
				prompt="y/n"
				default=
		fi

		# Ask the question
		printf "${lblue}[QUESTION]: ${1} [${prompt}]${reset} "
		read REPLY

		# Default?
		if [ -z "$REPLY" ]; then
			REPLY=$default
		fi

		# Check if the reply is valid
		case "$REPLY" in
			Y*|y*) return 0 ;;
			N*|n*) return 1 ;;
		esac
	done
}

# Pauses the program execution until the user presses ENTER:
pause(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="Press ENTER to continue..."
	fi
	printf "${lmagenta}${msg}${reset}\n"
	read pause
}

# Critical Error and Exit:
fatal(){
	local msg="$@"
	if [[ -z $msg ]]; then
		msg="Unknwon ERROR. Aborting...\n"
	fi
	error $msg
	pause
	exit 1
}

# Shows a menu with options and returns the selected option:
# Usage: menu <title> <options>
# Example: cities=("Madrid" "Paris" "London" "Rome" "Berlin" "Amsterdam" "Tokyo" "Kyoto"); menu "Choose a city:" ${cities}
menu(){
	local title="$1"
	shift
	local options=("$@")
	if [[ -z "$title" ]]; then
		title="Choose an option:"
	fi
	printf "${lmagenta}"
	printf "${title}\n"
	select option; do
		if [[ 1 -le "$REPLY" && "$REPLY" -le "$#" ]]; then
			info "Choosed $option\n"
			return $(($REPLY-1));
		else
			warning "Choose a valid between 1~$#: \n"
			printf "${lmagenta}"
		fi
	done
	printf "${reset}\n"
}

# Checks root access and set a new variable to run commands as root:
# Usage: check_root
# Example: check_root
check_root(){
	info "Getting user data..."
	USER_NAME=$(whoami)
	USER_ID=$(id -u)
	HOME=""
	runas=""
	if [ "${USER_ID}" == "0" ]; then
		export HOME="/${USER_NAME}"
		export runas=""
		success "You have ROOT ACCESS!"
		return 0
	fi
	export HOME="/home/${USER_NAME}"
	warning "You may not have sudo permissions."
	info "Testing sudo access..."
	
	if sudo echo "SUDO ACCESS..."; then
		export runas="sudo"
		success "You have SUDO ACCESS!"
		return 1
	fi
	fatal "You are not allowed to perform changes on the system! Try again as ROOT!"
}

# Checks for network access:
# Usage: check_network
# Example: check_network
check_network(){
	info "Checking network access..."
	if ping www.google.com -c 4; then
		success "Network available."
		return 0
	fi
	error "Network unreachable."
	return 1
}

# Installs packages via APT:
# Usage: pkg <package_list>
# Example: pkg curl wget git
pkg(){
	if "$runas" apt install "$@" -y; then
		success "Installed all packages."
		return 0
	fi
	error "Could not install the packages."
	return 1
}
