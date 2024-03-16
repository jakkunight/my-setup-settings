#!/bin/bash
#
# Script to mount my configs on any Debian-based linux distro.
# Author: Jakku Night (@jakkunight on GitHub and XDA Developers, jakku_night on Twitch and Jakku Night on YouTube.)
#
# This script and configurations are based on my own preferences, so if you want to add or remove features, 
# feel free to fork/clone this repo (https://github.com/jakkunight/my-setup-settings) and do your stuffs.
# I'm not responsable for damaging your system, making your computer blow up or causing a thermonuclear war.
# YOU HAVE BEEN WARNED.
#
# GUI environment:

source commons.sh

install_i3wm_pkg(){
  if ! pkg i3; then
    return 1
  fi
  return 0
}

install_rofi_pkg(){
  if ! pkg rofi; then
    return 1
  fi
  return 0
}

configure_polybar(){
  info "Copying dotfiles..."
  if [ -d "~/.config/" ]; then 
    "$runas" mkdir ~/.config
  fi
  "$runas" cp -rf ./dotfiles/polybar ~/.config

}

install_polybar_pkg(){
  if ! pkg polybar; then
    return 1
  fi

}
gui(){
	info "Installing GUI environment..."
	info "Installing i3wm, polybar and rofi..."
	info "Configuing i3wm..."
	info "Configuing polybar..."
	info "Configuing rofi..."
}
