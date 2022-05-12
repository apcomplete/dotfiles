if [ "$(uname -s)" == "Linux" ]
then
  sudo apt update
  sudo apt install -y curl
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
