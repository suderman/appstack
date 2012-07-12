#!/bin/sh

# 2012 Jon Suderman
# https://github.com/suderman/symlink/

# Open a terminal and run this command:
# curl https://raw.github.com/suderman/appstack/master/install.sh | sh

# Ensure /usr/local/bin exists
if [ ! -d "/usr/local" ]; then
  sudo mkdir -p /usr/local/bin
  sudo chown `whoami`:admin /usr/{local,local/bin}
fi

# Download appstack into /usr/local/bin
curl https://raw.github.com/suderman/appstack/master/appstack -o /usr/local/bin/appstack

# Set permissions
chmod +x /usr/local/bin/appstack

echo "Installed appstack to /usr/local/bin"
