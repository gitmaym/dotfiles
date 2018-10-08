#!/bin/env bash
#

mkdir ~/.vim
cp -rpv myvimrc-plugin ~/.vimrc
tar -zxvf vim-plugin.tgz -C ~/.vim/
