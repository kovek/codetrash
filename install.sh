#!/bin/bash

set -x

c=0
echo "cat script.vim >> ~/.vimrc ?"
while [[ $c != 'y' && $c != 'n' ]]
do
  read -n 1 c
done
if [[ $c == 'y' ]]
then
  cat script.vim >> ~/.vimrc
fi

c=0
echo "touch ~/bin/codetrash ?"
while [[ $c != 'y' && $c != 'n' ]]
do
  read -n 1 c
done
if [[ $c == 'y' ]]
then
  mkdir -p ~/bin/; touch ~/bin/codetrash
fi

set +x
