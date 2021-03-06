#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old
files="tmux.conf tmux zshrc zlogin gitconfig oh-my-zsh tern-config tmuxinator"
files_xdg="nvim"

function create_backup_dir {
    echo "Creating backup dir"
    mkdir -p $olddir
}

function create_vim_dirs {
    cd $dir
    mkdir -p "nvim/tmp/undo"
    mkdir -p "nvim/tmp/backup"
    mkdir -p "~/.config"
}

function backup_create_symlink {
    if [ -f ".$2" ]; then
        mv ~/.$2 $olddir
    fi

    echo "Creating symlink to $2 in home directory."
    ln -s $dir/$2 $1$2
}

function backup_create_symlinks {
    echo "Backing up dotfiles to $olddir"
    cd ~

    # Files in home folder
    for file in $files; do
        backup_create_symlink "$HOME/." "$file"
    done

    # Files in xdg
    for file in $files_xdg; do
        backup_create_symlink "$HOME/.config/" "$file"
    done
}

create_backup_dir
create_vim_dirs
backup_create_symlinks
