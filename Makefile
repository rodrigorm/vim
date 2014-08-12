SHELL := /bin/bash

.PHONY : install test test/*.vader

test : bundle/vader.vim/plugin/vader.vim
	vim -u vimrc -c 'Vader!* test/*'

test/*.vader : bundle/vader.vim/plugin/vader.vim vimrc
	vim -u vimrc -c 'Vader!* $@'

install : ~/.vimrc
~/.vimrc : bundle/vundle/autoload/vundle.vim
	@[[ -a $@ ]] || ln -s ~/.vim/vimrc $@
	@echo "File ~/.vimrc created"

bundle/vader.vim/plugin/vader.vim : bundle/vundle/autoload/vundle.vim
bundle/vundle/autoload/vundle.vim :
	git submodule update --init
	vim -u vimrc +BundleInstall +qall
