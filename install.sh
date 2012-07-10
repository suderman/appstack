#!/bin/sh
# curl https://raw.github.com/suderman/appstack/master/install.sh | sh

# Download appstack into /usr/local/bin
curl https://raw.github.com/suderman/app/master/appstack -o /usr/local/bin/appstack

# Set permissions
chmod +x /usr/local/bin/appstack

echo "Installed appstack to /usr/local/bin"
