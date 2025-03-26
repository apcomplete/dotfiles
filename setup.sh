#!/bin/bash

# https://github.com/Parth/dotfiles
install() {
  # This could def use community support
  # Don't use apt, it's also a java util and might detect that
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get install "$@" -y

  elif [ -x "$(command -v brew)" ]; then
    brew install "$@"

  else
    echo "I'm not sure what your package manager is! Please install $@ on
    your own and run this deploy script again."
  fi
}

update_packages() {
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update && sudo apt-get dist-upgrade -y

  elif [ -x "$(command -v brew)" ]; then
    brew update && brew upgrade

  else
    echo "I'm not sure what your package manager is! Please update packages on
    your own and run this deploy script again."
  fi
}

check_for_software() {
  echo "Checking to see if $1 is installed"
  command=${2-"$1"}
  if ! [ -x "$(command -v "$command")" ]; then
    install "$1"
  else
    echo "$1 is installed."
  fi
}

check_default_shell() {
  if [ -z "${SHELL##*zsh*}" ]; then
    echo "Default shell is zsh."
  else
    chsh -s "$(which zsh)"
  fi
}

echo "We're going to do the following:"
echo "1. Check to make sure you have zsh, vim, and tmux installed"
echo "2. We'll help you install them if you don't"
echo "3. We're going to check to see if your default shell is zsh"
echo "4. We'll try to change it if it's not"

packages=(
  autoconf
  bc
  curl
  git
  hub
  libbz2-dev
  libdb-dev
  libffi-dev
  libgdbm-dev
  libgdbm6
  libgmp-dev
  liblzma-dev
  libncurses5-dev
  libncursesw5-dev
  libreadline-dev
  libreadline6-dev
  libsqlite3-dev
  libssl-dev
  libxml2-dev
  libxmlsec1-dev
  libyaml-dev
  patch
  pspg
  ripgrep
  xz-utils
  zlib1g-dev
  zsh
)

update_packages

for package in "${packages[@]}"; do
  install "${package}"
done

check_default_shell

export PATH=$PATH:~/.asdf/bin

if [ ! -x "$(command -v asdf)" ]; then
  echo "Install asdf"
  echo
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
else
  echo "asdf already installed"
  echo
fi

asdf_plugins=(
  nodejs
  elixir
  erlang
)
for package in "${asdf_plugins[@]}"; do
  asdf plugin add "${package}"
  asdf install "${package}" latest
  asdf global "${package}" latest
  echo
done

echo "Install neovim"
if [[ "$OSTYPE" == "linux-gnu"* ]];
then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz
fi


echo "Install zplug"
echo
if [ ! -d "${HOME}/.zplug" ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Ensure directory exists
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
# Nvim is configured to use this directory for swap files
mkdir -p "${HOME}/.vim/tmp"

# Delete the neovim directory if it exists since we're just going to symlink the entire folder into .config
rm -rf "${XDG_CONFIG_HOME}/nvim"

echo
echo "Linking in other files"
ln -sf "$HOME/dotfiles/nvim" $XDG_CONFIG_HOME
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/gitignore" "$HOME/.gitignore"

# Create dot files to reference our dotfiles
echo "source $HOME/dotfiles/aliases.zsh" > "$HOME/.aliases"
echo "source $HOME/dotfiles/exports.zsh" > "$HOME/.exports"
echo "source $HOME/dotfiles/profile.zsh" > "$HOME/.profile"

echo "source $HOME/dotfiles/zsh/zshrc" > "$HOME/.zshrc"
echo "tmux source-file $HOME/dotfiles/tmux/tmux.conf" >"$HOME/.tmux.conf"

echo
echo "Please log out and log back in for default shell to be initialized."
