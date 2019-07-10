#!/bin/bash

dotfolder=$(pwd)
cd tmp/

# Create symbolic links
#
ln -s "$dotfile/.zshrc" .zshrc
ln -s "$dotfile/.vimrc" .vimrc

# Move generated symbolic links to final destinations
#
mv .zshrc ~/.zshrc
mv .vimrc ~/.vimrc

cd $dotfile

