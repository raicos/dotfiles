#!/bin/sh

DOT_FILES=(.zshrc .emacs.d)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
