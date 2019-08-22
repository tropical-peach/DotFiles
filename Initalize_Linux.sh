#
#  ████████           ██                     ██       ██                         
# ██░░░░░░           ░██           ██████   ░██      ░░                          
#░██         █████  ██████ ██   ██░██░░░██  ░██       ██ ███████  ██   ██ ██   ██
#░█████████ ██░░░██░░░██░ ░██  ░██░██  ░██  ░██      ░██░░██░░░██░██  ░██░░██ ██ 
#░░░░░░░░██░███████  ░██  ░██  ░██░██████   ░██      ░██ ░██  ░██░██  ░██ ░░███  
#       ░██░██░░░░   ░██  ░██  ░██░██░░░    ░██      ░██ ░██  ░██░██  ░██  ██░██ 
# ████████ ░░██████  ░░██ ░░██████░██       ░████████░██ ███  ░██░░██████ ██ ░░██
#░░░░░░░░   ░░░░░░    ░░   ░░░░░░ ░░        ░░░░░░░░ ░░ ░░░   ░░  ░░░░░░ ░░   ░░ 

#mkdir ~/gits
#sudo apt-get update
sudo apt-get install rxvt-unicode-256color compton toilet figlet git clang gcc g++ cmake curl zsh stow
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/vim/vim.git ~/gits/vim
mv ~/.bashrc ~/.bashrc.BKP
stow ./home_resources -t ~/
stow ./fonts -t /user/share/figlet/fonts/
#cd /usr/lib/urxvt && sudo rm -r perl/ && sudo git clone https://github.com/tropical-peach/perl.git


printf "Ensure fonts and other path dependant files are installed"
printf "Don't forget to compile VIM"
echo "----------"
