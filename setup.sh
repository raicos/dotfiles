#!/bin/sh

DOT_FILES=(.zshrc .config)

for file in ${DOT_FILES[@]}
do
    ln -sfv $HOME/dotfiles/$file $HOME/$file
done
