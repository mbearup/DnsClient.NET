#!/bin/bash -e
if [ -z "$1" ]; then
  # By default install to /usr/share/dsts, requires sudo
  dest=/usr/share/dsts
  sudo=sudo
  owner=root
else
  # Specify an alternate folder to install without sudo
  dest=$1
  sudo=""
  owner=$USER
fi
if [ ! -d $dest ]; then
    echo "INFO: $dsts does not exist. Creating..."
    $sudo install -d -o $owner -g $owner -m 755 $dest
fi

echo "INFO: Installing DNS library to $dest"
$sudo install -o $owner -g $owner -m 644 "src/DnsClient/bin/Debug/netcoreapp2.0/DnsClient.dll" $dest
