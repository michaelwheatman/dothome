#!/usr/bin/env bash
# Michael Wheatman
# Last Update: April 11, 2019

DOT_HOME='$HOME/.home'
DOT_FILE_REPO='dotfiles'

function make_home() {
	DOT_FILE_REPO_ADDRESS='httos://github.com/michaelwheatman//$DOT_FILE_REPO'
	if [! -d $DOT_HOME]; then
		mkdir $DOT_HOME
	fi
	cd $DOT_HOME
	if [! -d $DOT_FILE_REPO]; then
		git clone $DOT_FILE_REPO_ADDRESS
		cd $DOT_FILE_REPO
	else
		cd $DOT_FILE_REPO
		git pull
	fi

	ln -s src/bashrc ~/.bashrc
	ln -s src/bash_aliases ~/.bash_aliases
	ln -s src/vimrc ~/.vimrc
        ln -s src/bash/functions.sh ~/.functions.sh

	if [! -d '~/src/bash']; then
		mkdir '~/src/bash'
	fi

	ln -s src/bash ~/bin/bash

	if [! -d '~/src/python']; then
		mkdir '~/src/python'
	fi

	ln -s 'src/python' '~/bin/python'
}

function update_home() {
	if [! -d '$DOT_HOME/$DOT_FILE_REPO']; then
		make_home
		return
	fi
	cd '$DOT_HOME/$DOT_FILE_REPO'
	git pull
}

function upload_changes() {
	if [! -d '$DOT_HOME/$DOT_FILE_REPO']; then
		echo "dotfiles repo does not exist. consider creating it."
		return
	fi
	cd '$DOT_HOME/$DOT_FILE_REPO'
	git commit -am "upload changes to dot files"
	git push
}
