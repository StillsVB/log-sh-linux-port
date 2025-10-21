#!/bin/bash
mkdir -p ~/bin logs/general projects
curl -sSL https://raw.githubusercontent.com/good1/log-sh/main/log.sh -o ~/bin/log.sh
chmod +x ~/bin/log.sh
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.profile
echo "🎉 log.sh installed! Run: log"