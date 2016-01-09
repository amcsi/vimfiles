# Update submodules.
git submodule update --init --recursive

# Create symlink from .vim to vimfiles
ln -s vimfiles ../.vim

# Install plugins.
vim +PluginInstall +qall
