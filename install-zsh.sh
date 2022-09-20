#!/bin/bash

user_exists(){ id "$1" &>/dev/null; } # silent, it just sets the exit code

if [ $# -eq 0 ]
  then
    echo "No arguments supplied" >&2
    echo "{Usage : $0 <username>}"
fi

if user_exists "$1"; code=$?; then  # use the function, save the code
    sudo apt update
    echo "Installing zsh."
    sudo apt install zsh -y
    echo "Changing default shell for $1 user.."
    sudo chsh -s /bin/zsh $1
    echo "Cloning  zsh-syntax-highlighting to ~/.zsh/zsh-syntax-highlighting ..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting 2> /dev/null || exit 1
    echo "Cloning  zsh-autosuggestions to ~/.zsh/zsh-autosuggestions ...."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 2> /dev/null || exit 1
    echo "Creating a backup of current zshrc in ~/.zshrc-backup ....."
    mv ~/.zshrc ~/.zshrc-backup
    echo "Copying kali zshrc config to ~/.zshrc ......"
    cp zshrc-config ~/.zshrc
    echo "Sourcing zshrc ......."
    source ~/.zshrc
else
    echo 'user $1 not found' >&2  # error messages should go to stderr
fi
exit $code  # set the exit code, ultimately the same set by `id`



