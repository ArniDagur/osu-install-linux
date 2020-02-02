#!/bin/bash
set -e

export WINEPREFIX="$HOME/.osu-patch"
export WINEARCH=win32

# Exit if wine, curl, or winetricks is not installed
wine --version > /dev/null || echo "You need to install wine"
curl --version > /dev/null || echo "You need to install curl"
winetricks --version > /dev/null || echo "You need to install winetricks"

# Create osu-folder symlink
echo "Creating symbolic link to the Osu! directory at ~/osu-folder ..."
ln -sf $WINEPREFIX/drive_c/users/$USER/Local\ Settings/Application\ Data/osu\! \
    $HOME/osu-folder

# Install start script
echo "Installing start script to /usr/local/bin/osu ..."
sudo cp osu /usr/local/bin/osu

# Install kill script
echo "Installing kill script to /usr/local/bin/osukill ..."
sudo cp osukill /usr/local/bin/osukill

# Install osu! logo
echo "Installing Osu! logo to ~/.local/share/icons/osu!.png ..."
mkdir -p $HOME/.local/share/icons
cp osu_icon.png $HOME/.local/share/icons/osu\!.png

# Install Desktop shortcut
echo "Installling Osu! desktop shortcut to ~/.local/share/applications/osu!.desktop ..."
mkdir -p $HOME/.local/share/applications
cp osu\!.desktop $HOME/.local/share/applications/osu\!.desktop

# Install the .NET framework
echo "Installing .NET framework..."
winetricks dotnet40
# Run the Windows installation wizard through Wine
echo "Downloading Osu! installation wizard for Windows..."
curl -o $WINEPREFIX/osuinstall.exe https://m1.ppy.sh/r/osu\!install.exe
echo "Running Osu! installation wizard for Windows through Wine..."
wine $WINEPREFIX/osuinstall.exe
