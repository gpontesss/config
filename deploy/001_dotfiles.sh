#!/bin/sh

SRCDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/..)

for CONFDIR in $SRCDIR/.config/*; do
    TARGETDIR=$HOME/.config/
    echo "Creating symlink from $CONFDIR to $TARGETDIR"
    ln -s $CONFDIR $TARGETDIR
done

echo 

for DOTFILE in .vimrc .Xresources .profile; do
    echo "Creating symlink from $SRCDIR/$DOTFILE to $HOME"
    ln -s $SRCDIR/$DOTFILE $HOME/
done
