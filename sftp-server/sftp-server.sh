#!/bin/bash

if [ ! "$1" ]
then
    USERNAME=ssh-user
else
    USERNAME="$1"   
fi

if [ ! "$2" ]
then
    PORT=5000
else
    PORT="$2"   
fi

PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c"${1:-32}";echo;)

ssh-keygen -t rsa -N "" -C "$USERNAME" -f "./openssh/$USERNAME.pem"

docker build --build-arg PASSWORD="$PASSWORD" --build-arg USERNAME="$USERNAME" ./openssh/ -t sftp-server:"$USERNAME"

docker run -dit --name sftpserver-"$USERNAME" \
    --hostname sftpserver-"$USERNAME" \
    -v sftpserver-"$USERNAME":/data \
    -p "$PORT":22 sftp-server:"$USERNAME"