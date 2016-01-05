# Update submodules.
git submodule update --init --recursive

# Install plugins.
vim +PluginInstall +qall

# Create symlink from .vim to vimfiles
ln -s vimfiles ../.vim
