#!/bin/sh 

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor

brew install zsh
brew install tmux
brew install neovim/neovim/neovim
brew install git
brew install python3
brew install zplug
brew cask install java
brew install ghostscript
brew install imagemagick

git clone https://github.com/altercation/solarized.git

grep '/usr/local/bin/zsh' /etc/shells
if [ "$?" -eq 0 ]; then
    echo 'already /usr/local/bin/zsh'
else
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
fi
chsh -s /usr/local/bin/zsh

git clone https://github.com/raicos/dotfiles.git
cd dotfiles
sh setup.sh
cd ~/

exec $SHELL -l

