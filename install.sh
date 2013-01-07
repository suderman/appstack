#!/bin/sh

# 2013 Jon Suderman
# https://github.com/suderman/appstack/

# Open a terminal and run this command:
# curl https://raw.github.com/suderman/appstack/master/install.sh | sh

# Ensure /usr/local/bin exists
if [ ! -d "/usr/local" ]; then
  sudo mkdir -p /usr/local/bin
  ULB_OWNER=`whoami`:`ls -ld /usr | awk '{print $4}'`
  sudo chown $ULB_OWNER /usr/{local,local/bin}
fi

# Download appstack into /usr/local/bin
sudo curl https://raw.github.com/suderman/appstack/master/appstack -o /usr/local/bin/appstack

# Set permissions
ULB_OWNER=`ls -ld /usr/local/bin | awk '{print $3}'`:`ls -ld /usr/local/bin | awk '{print $4}'`
sudo chown $ULB_OWNER /usr/local/bin/appstack 
sudo chmod +x /usr/local/bin/appstack

echo "Installed appstack to /usr/local/bin"
