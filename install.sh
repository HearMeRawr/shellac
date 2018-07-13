#!/bin/bash

echo "init shellac installer"
echo "Checking for $HOME/Themes..."
if [ -d "$HOME/Themes" ]; then
    
    echo "There's already a $HOME/Themes directory..."
    
else
    
    echo "Making $HOME/Themes directory..."
    mkdir $HOME/Themes
    
fi

echo "Checking for default themes..."
if [ -d "$HOME/Themes/default" ]; then
    
    echo "There's already a default theme!"
    
else
    
    echo "Making default theme from current config..."
    mkdir $HOME/Themes/default
    DEFAULT=$HOME/Themes/default
    mkdir $DEFAULT/i3
    mkdir $DEFAULT/i3status
    mkdir $DEFAULT/termite
    
    echo "Checking if there's a custom i3 config..."
    if [ -f ~/.config/i3/config ]; then
        echo "Copying $HOME/.config/i3/config"
        cp $HOME/.config/i3/config $DEFAULT/i3/config
    elif [ -f ~/.i3/config ]; then
        echo "Copying $HOME/.i3/config"
        cp $HOME/.i3/config $DEFAULT/i3/config
        echo "Making directory $HOME/.config/i3..."
        mkdir $HOME/.config/i3
    else
        echo "!!! -- No custom i3 config!"
        echo "Copying /etc/i3/config"
        cp /etc/i3/config $DEFAULT/i3/config
        echo "+++ -- Consider editing $DEFAULT/i3/config"
        echo "Making $HOME/.config/i3/config..."
        cp /etc/i3/config $HOME/.config/i3/config
    fi
    
    echo "Checking for custom termite config..."
    if [ -f "$HOME/.config/termite/config" ]; then
        echo "Copying $HOME/.config/termite/config"
        cp $HOME/.config/termite/config $DEFAULT/termite/config_dark
    else
        echo "!!! -- No custom termite config!"
        echo "Copying /etc/xdg/termite/config"
        cp /etc/xdg/termite/config $DEFAULT/termite/config_dark
        echo "+++ -- Consider editing $DEFAULT/termite/config"
        echo "Making $HOME/.config/termite/config..."
        cp /etc/xdg/termite/config $HOME/.config/termite/config
    fi
    
    echo "Checking for custom i3status config..."
    if [ -f ~/.config/i3status/config ]; then
        echo "Copying $HOME/.config/i3status/config"
        cp $HOME/.config/i3status/config $DEFAULT/i3status/config
    else
        echo "!!! -- No custom i3 status!"
        echo "Copying /etc/i3status.conf"
        cp /etc/i3status.conf $DEFAULT/i3status/config
        echo "Consider editing $DEFAULT/i3status/config"
        cp /etc/i3status.conf $HOME/.config/i3status/config
    fi
    echo "Done with default theme..."
fi

echo "Installing shellac..."

sudo cp ./shellac /usr/local/bin/shellac
sudo chmod +x /usr/local/bin/shellac

echo "shellac installed in /usr/local/bin/shellac"
