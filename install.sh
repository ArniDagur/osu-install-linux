#!/bin/bash

# -- Install patched wine --
if grep -q "\[thepoon\]" /etc/pacman.conf; then
    echo "The Poon's repo is already in /etc/pacman.conf; skipping..."
else
    echo "Adding The Poon's repo to /etc/pacman.conf"
    sudo sh -c 'echo "[thepoon]
    Server = https://archrepo.thepoon.fr
    Server = https://mirrors.celianvdb.fr/archlinux/thepoon" >> /etc/pacman.conf'
fi
sudo pacman-key --keyserver hkps://hkps.pool.sks-keyservers.net -r C0E7D0CDB72FBE95
sudo pacman-key --keyserver hkps://hkps.pool.sks-keyservers.net --lsign-key C0E7D0CDB72FBE95
sudo pacman -Sy --needed --noconfirm wine-osu winetricks
sudo pacman -S --needed --noconfirm curl > /dev/null # Install curl if needed

# -- Install Osu! --
export WINEPREFIX="$HOME/.osu-patch"
export WINEARCH=win32

# Create osu-folder symlink
echo "Creating symbolic link to the Osu! directory at ~/osu-folder ..."
ln -s $WINEPREFIX/drive_c/users/$USER/Local\ Settings/Application\ Data/osu\! \
    $HOME/osu-folder > /dev/null
# Install start script
echo "Installing start script to /usr/local/bin/osu ..."
sudo cp osu /usr/local/bin/osu
# Install kill script
echo "Installing kill script to /usr/local/bin/osukill ..."
sudo cp osukill /usr/local/bin/osukill
# Install Desktop shortcut
echo "Installing Osu! logo to ~/.local/share/icons/osu!.png ..."
curl -o $HOME/.local/share/icons/osu\!.png https://upload.wikimedia.org/wikipedia/commons/d/d3/Osu%21Logo_%282015%29.png
echo "Installling Osu! desktop shortcut to ~/.local/share/applications/osu!.desktop ..."
cp osu\!.desktop $HOME/.local/share/applications/osu\!.desktop

# Install the .NET framework
echo "Installing .NET framework..."
winetricks dotnet40
# Run the Windows installation wizard through Wine
echo "Downloading Osu! installation wizard for Windows..."
curl -o $WINEPREFIX/osuinstall.exe https://m1.ppy.sh/r/osu\!install.exe
echo "Running Osu! installation wizard for Windows through Wine..."
/opt/wine-osu/bin/wine $WINEPREFIX/osuinstall.exe
