#!/bin/bash

dotfolder=$(pwd)
cd tmp/

# Create symbolic links
#
ln -s "$dotfolder/src/.zshrc" .zshrc
ln -s "$dotfolder/src/.vimrc" .vimrc
ln -s "$dotfolder/src/.hyper.js" .hyper.js

# Move generated symbolic links to final destinations
#
mv .zshrc ~/.zshrc
mv .vimrc ~/.vimrc
mv .hyper.js ~/.hyper.js

cd $dotfile

