#!/bin/bash
if type nvim; then
	echo "nvim"
else
	git clone https://github.com/neovim/neovim.git
	cd ~/neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd
fi

deinCachePath=~/.cache/dein
installerPath=~/deinInstaller.sh
if [ -e $deinCachePath ]; then
	echo $deinCachePath
else
	curl -sS https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $installerPath
	sh $installerPath $deinCachePath
	rm $installerPath
fi

python3 -m pip install --user --upgrade pynvim
