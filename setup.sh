#!/bin/sh

DOT_FILES=(.zshrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
    ln -sfv $HOME/dotfiles/$file $HOME/$file
done

ln -sfvn $HOME/dotfiles/.config $HOME/.config
