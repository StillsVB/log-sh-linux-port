#!/bin/bash
mkdir -p ~/bin logs/general projects
curl -sSL https://raw.githubusercontent.com/StillsVB/log-sh-linux-port/main/log.sh -o ~/bin/log.sh
chmod +x ~/bin/log.sh
sudo cp ~/bin/log.sh /usr/local/bin/log
echo "🎉 log.sh installed! Run: log"