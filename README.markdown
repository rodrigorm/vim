Installation
------------

* Clone this repository: `git clone git://github.com/rodrigorm/vim.git ~/.vim`
* Make a symlink to vimrc file `ln -s ~/.vim/vimrc ~/.vimrc`
* Initialize git submodules to enable `vundle`[https://github.com/gmarik/vundle], at `~/.vim` run `git submodule init` and `git submodule update`
* Install configured bundles using `vim +BundleInstall`
* Done!

Dependencies
------------

* Install *exuberant-ctags* for TagList bundle.
 * `apt-get install exuberant-ctags`
* To use ctags with PEAR library you need to run a script at `bin` using: `./.vim/bin/ctags_pear`
