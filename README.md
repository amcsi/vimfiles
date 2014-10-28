# amcsi / Attila Szeremi's ~/.vim/ folder

## Requirements

Git (for vundle)

### Installation:

1)

##### On windows:

    $ git clone https://github.com/amcsi/vimfiles.git ~/vimfiles

##### On unix-like:

    $ git clone https://github.com/amcsi/vimfiles.git ~/.vim
    
2) Run:

    $ git submodule update --init --recursive
    
3)

Copy [toHomeVimrc.vim](toHomeVimrc.vim) to your `~/.vimrc`

4) Finally run:

    $ vim +PluginInstall +qall ### <- and run this any time new Bundles have been added to apply them
