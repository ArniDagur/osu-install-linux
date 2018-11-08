#!/bin/bash
DROPBOX_OSU_DIR=$HOME/Dropbox/Apps/osu\!
OSU_DIR=$HOME/osu-folder

echo "Using Dropbox folder $DROPBOX_OSU_DIR and Osu! folder $OSU_DIR."

if [ ! -L $OSU_DIR/Skins ]; then
    echo "Deleting all local skins..."
    rm -rf $OSU_DIR/Skins/
    echo "Connecting skins folder to Dropbox..."
    ln -s $DROPBOX_OSU_DIR/Skins/ $OSU_DIR/Skins
else
    echo "Skin folder already connected to Dropbox; skipping..."
fi

if [ ! -L $OSU_DIR/Songs ]; then
    echo "Deleting all local beatmaps..."
    rm -rf $OSU_DIR/Songs/
    echo "Connecting beatmap folder to Dropbox..."
    ln -s $DROPBOX_OSU_DIR/Songs/ $OSU_DIR/Songs
else
    echo "Beatmap folder already connected to Dropbox; skipping..."
fi
