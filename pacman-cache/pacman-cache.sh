#!/bin/bash

if [ ! -d "$HOME/pacman-cache" ]
    then
        mkdir -p "$HOME/pacman-cache"
fi

docker run -dit \
    -v "$HOME/pacman-cache":/srv/ \
    -v "$(pwd)/nginx.conf":/etc/nginx/nginx.conf:ro \
    --restart unless-stopped -p 80:80 --name pacman-cache nginx:alpine