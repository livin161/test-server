sudo apt install python

#sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#
#python3.8 get-pip.py
#
#sudo find / -name pip
#
#sudo touch ~/.bashrc
#
#echo 'alias pip="~/.oh-my-zsh/plugins/pip"' >> ~/.bashrc
#source ~/.bashrc

sudo apt install python3-pip

pip3 --version

pip3 install powerline-status

pip3 show powerline-status

pip3 install psutil i3ipc

touch ~/.vimrc

echo '
set laststatus=2           " Always display the status bar
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
' >> ~/.vimrc


echo '
# ---
## Use powerline
USE_POWERLINE="true"
# source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
## Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
## To customize prompt, run `p10k configure` or edit /usr/share/zsh/p10k.zsh.
#[[ ! -f /usr/share/zsh/p10k.zsh ]] || source /usr/share/zsh/p10k.zsh

# ---
# Use "the genuine" powerline
# See https://wiki.archlinux.org/index.php/Powerline#Zsh
powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

' >> ~/.zshrc