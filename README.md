# amcsi / Attila Szeremi's ~/.vim/ folder

## Requirements

Git (for vundle)

### Installation:

1) Backup your current `~/.vimrc` file and `~/.vim` or `~/vimfiles` folders and make sure they're not there with those names.

##### On windows:

```sh
git clone https://github.com/amcsi/vimfiles.git ~/vimfiles
```

##### On unix-like:

```sh
git clone https://github.com/amcsi/vimfiles.git ~/vimfiles
ln -s vimfiles ~/.vim
```

2) Run:

```
cd ~/vimfiles
cp toHomeVimrc ~/.vimrc
bin/install.sh
```
