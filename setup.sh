#!/bin/zsh

# add submodule
git submodule update --init --recursive

# prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# symlink dotfiles
ln -sf ~/src/github.com/strsk/dotfiles/.vim ~/.vim
ln -sf ~/src/github.com/strsk/dotfiles/.zprezto ~/.zprezto
ln -sf ~/src/github.com/strsk/dotfiles/.vimrc ~/.vimrc
ln -sf ~/src/github.com/strsk/dotfiles/.zpreztorc ~/.zpreztorc
ln -sf ~/src/github.com/strsk/dotfiles/.zshrc ~/.zshrc

# source .zsh files
source ~/.zshrc
source ~/.zpreztorc
