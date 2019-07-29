#!/bin/bash

nvimPath=/var/tmp/neovim
if [ ! -e $nvimPath ]; then
	git clone https://github.com/neovim/neovim.git $nvimPath
fi
cd $nvimPath
if [ ! -e build ]; then
	make CMAKE_BUILD_TYPE=RelWithDebInfo
fi
if !(type nvim >/dev/null 2>&1); then
	sudo make install
fi
git fetch
git diff --exit-code --quiet
if [[ $? -eq 1 ]]; then
	git merge
	sudo make install
fi

cd `dirname $0`
deinCachePath=~/.cache/dein
if [ -e $deinCachePath ]; then
	echo $deinCachePath
else
	installerPath=/var/tmp/deinInstaller.sh
	curl -sS https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $installerPath
	sh $installerPath $deinCachePath
fi

cd `dirname $0`
python3 -m pip install --user --upgrade pynvim
