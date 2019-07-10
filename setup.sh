#!/bin/bash

dotfolder=$(pwd)
cd tmp/

# Create symbolic links
#
ln -s "$dotfolder/src/.zshrc" .zshrc
ln -s "$dotfolder/src/.vimrc" .vimrc

# Move generated symbolic links to final destinations
#
mv .zshrc ~/.zshrc
mv .vimrc ~/.vimrc

cd $dotfile

