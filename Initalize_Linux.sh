#
#  ████████           ██                     ██       ██                         
# ██░░░░░░           ░██           ██████   ░██      ░░                          
#░██         █████  ██████ ██   ██░██░░░██  ░██       ██ ███████  ██   ██ ██   ██
#░█████████ ██░░░██░░░██░ ░██  ░██░██  ░██  ░██      ░██░░██░░░██░██  ░██░░██ ██ 
#░░░░░░░░██░███████  ░██  ░██  ░██░██████   ░██      ░██ ░██  ░██░██  ░██ ░░███  
#       ░██░██░░░░   ░██  ░██  ░██░██░░░    ░██      ░██ ░██  ░██░██  ░██  ██░██ 
# ████████ ░░██████  ░░██ ░░██████░██       ░████████░██ ███  ░██░░██████ ██ ░░██
#░░░░░░░░   ░░░░░░    ░░   ░░░░░░ ░░        ░░░░░░░░ ░░ ░░░   ░░  ░░░░░░ ░░   ░░ 

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable rxvt-unicode-256color compton toilet figlet git google-chrome-stable vim clang gcc g++ cmake curl zsh 
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./.vimrc ./.Xdefaults ./.bashrc ./.zshrc -t ~/
cd /usr/lib/urxvt && sudo rm -r perl/ && sudo git clone https://github.com/rad-/perl.git


printf "Ensure fonts and other path dependant files are installed"
