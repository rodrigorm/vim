Installation
------------

* Clone this repository: `git clone git://github.com/rodrigorm/vim.giti ~/.vim`
* Make a symlink to vimrc file `ln -s ~/.vim/vimrc ^/.vimrc`
* Initialize git submodules to enable `vundle`, at `~/.vim` run `git submodule init` and `git submodule update`
* Install configured bundles using `vim +BundleInstall`
* Done!

Dependencies
------------

* Install *exuberant-ctags* for TagList bundle.
 * `apt-get install exuberant-ctags`
