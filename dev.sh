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
# DEVELOPMENT SETUP:

# Import modules:
source ./commons.sh

install_cargo_rustup(){
  info "Installing Rust setup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  success "Installed Rust! Now you're a 'Rustacean'."
}

install_bun(){
  info "installing BunJS..."
  curl -fsSL https://bun.sh/install | bash
  success "Installed BunJS!"
}

install_nodejs_fnm(){
  info "Installing Fast Node Manager..."
  curl -fsSL https://fnm.vercel.app/install | bash
  success  "Installed!"
  info "Installing NodeJS..."
  fnm install --lts
  success "Installed NodeJS!"
}

dev_setup(){
  if ! install_cargo_rustup; then 
    return 1
  fi
  if ! install_bun; then
    return 1
  fi
  if ! install_nodejs_fnm; then
    return 1
  fi  
  return 0
}
