#!/bin/bash

cd `dirname $0`
nvimPath=~/neovim
if type nvim; then
	echo "nvim"
else
	git clone https://github.com/neovim/neovim.git $nvimPath
	cd $nvimPath
	pwd
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
fi

cd `dirname $0`
deinCachePath=~/.cache/dein
if [ -e $deinCachePath ]; then
	echo $deinCachePath
else
	installerPath=~/deinInstaller.sh
	curl -sS https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $installerPath
	sh $installerPath $deinCachePath
	rm $installerPath
fi

cd `dirname $0`
python3 -m pip install --user --upgrade pynvim
