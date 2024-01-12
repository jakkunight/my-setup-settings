#!/usr/bin/bash
#
# Script to mount my configs on any Debian-based linux distro.
# Author: Jakku Night (@jakkunight on GitHub and XDA Developers, jakku_night on Twitch and Jakku Night on YouTube.)
#
# This script and configurations are based on my own preferences, so if you want to add or remove features, 
# feel free to fork/clone this repo (https://github.com/jakkunight/my-setup-settings) and do your stuffs.
# I'm not responsable for damaging your system, making your computer blow up or causing a thermonuclear war.
# YOU HAVE BEEN WARNED.
#
# Program list:
# 	ZSH (default shell)
# 	Powerlevel10k (default style)
# 	Hack Nerd Fonts (default system fonts)
# 	Tmux (terminal multiplexer)
# 	Micro (default text editor)
# 	NeoVim (default text editor)
# 	

# Import common lib:
source "./commons.sh"

# Hack Nerd Fonts:
install_hack_nf(){
	info "Installing Hack Nerd Fonts..."
	if ! "$runas" mkdir -p ~/.local/share/fonts; then
		warning "Font dir already exists!"
	fi
	mkdir fonts
	cd fonts
	info "Downloading fonts..."
	"$runas" curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.tar.xz
	info "Decompressing tarball..."
	tar -xf Hack.tar.xz
	cd ..
	info "Copying..."
	"$runas" cp -rf fonts ~/.local/share/fonts
	rm -rf fonts
	success "Hack Nerd Fonts are installed!"
	return 0
}

# ZSH:
install_zsh_pkg(){
	info "Installing ZSH..."
	if ! pkg zsh; then
		error "ZSH was not installed."
		return 1
	fi
	success "Installed ZSH."
	return 0
}

# Powerlevel10k:
install_pl10k(){
	info "Installing Powerlevel10k..."
	if ! git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k; then
		error "Could not install Powerlevel10k."
		return 1
	fi
	success "Installed Powerlevel10k."
	info "Configuring..."
	if ! "$runas" echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc; then
		error "Could not configure Powerlevel10k."
		return 1
	fi
	success "Configured Powerlevel10k."
	info "Reloading shell..."
	source ~/.zshrc
	warning "Shell was reloaded."
	return 0
}

# Tmux:
install_tmux_pkg(){
	info "Installing Tmux..."
	if ! pkg tmux; then
		error "Tmux was not installed."
		return 1
	fi
	success "Installed Tmux."
	return 0
}

install_tokyonight_plug(){
	info "Installing tokyonight theme for Tmux..."
	echo 'set -g @plugin "janoamaral/tokyo-night-tmux"' >> ~/.tmux.conf
	return 0
}

install_tpm(){
	info "Installing TPM..."
	if ! git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; then
		error "Cannot install TPM."
		return 0
	fi
	success "Installed TPM!"
	info "Configuring..."
	if [ -f ~/.tmux.conf ]; then
		"$runas" rm -f ~/.tmux.conf
	fi
	"$runas" touch ~/.tmux.conf
	echo "set -g mouse on" >> ~/.tmux.conf
	echo "set -g history-limit 5000" >> ~/.tmux.conf
	echo "set -g default-terminal 'xterm-256color'" >> ~/.tmux.conf
	# Your plugin installer function here:
	install_tokyonight_plug
	echo "# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)" >> ~/.tmux.conf
	echo "run '~/.tmux/plugins/tpm/tpm'" >> ~/.tmux.conf
	success "Installed TPM!"
	info "tmux source ~/.tmux.conf # Run this to reload the Tmux config and then press 'Prefix-I'"
	return 0
}

# Micro:
install_micro_pkg(){
	info "Installing Micro..."
	if ! pkg micro; then
		error "Micro was not installed."
		return 1
	fi
	success "Installed Micro."
	info "Configuring..."
	micro -plugin install quoter
	micro -plugin install comment
	micro -plugin install filemanager
	success "Configured Micro!"
	return 0
}


# NeoVim:
install_nvim_gh(){
	info "Installing necessary tools for building NeoVim..."
	if ! pkg ninja-build gettext cmake unzip curl; then
		error "Cannot install necessary tools for building NeoVim. Aborting..."
		return 1
	fi
	info "Downloading sources..."
	git clone https://github.com/neovim/neovim
	success "Downloaded sources."
	cd neovim
	info "Building..."
	if ! "$runas" make CMAKE_BUILD_TYPE=RelWithDebInfo; then
		error "Can't build NeoVim. Aborting..."
		return 1
	fi
	success "NeoVim has been compiled!"
	info "Installing..."
	if ! "$runas" make install; then
		error "Could not install NeoVim."
		return 1
	fi
	cd ..
	"$runas" rm -rf neovim
	success "NeoVim has been installed!"
	return 0
}

install_nvchad_gh(){
	info "Installing dependencies..."
	if ! pkg tree-sitter-cli lua5.4; then
		warning "You may probably won't be able to use some NV_CHAD features."
	fi
	success "You are able to use all NV_CHAD features!"
	info "Installing NV_CHAD..."
	if ! git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim; then
		"$runas" rm -rf ~/.config/nvim
		"$runas" mkdir ~/.config/nvim
		error "You are NOT enough \"CHAD\" to install NV CHAD."
		return 1
	fi
	success "You are now a GIGA CHAD of coding with NV_CHAD!"
}

shell_setup(){
	if ! install_hack_nf; then
		return 1
	fi
	if ! install_zsh_pkg; then
		return 1
	fi
	if ! install_pl10k; then
		return 1
	fi
	if ! install_tmux_pkg; then
		return 1
	fi
	if ! install_tpm; then
		return 1
	fi
	if ! install_micro_pkg; then
		return 1
	fi
	if ! install_neovim_gh; then
		return 1
	fi
	if ! install_nvchad_gh; then
		return 1
	fi
}
