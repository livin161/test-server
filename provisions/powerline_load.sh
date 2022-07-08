echo "Установка powerline"

sudo apt install python

sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python3.8 get-pip.py

sudo find / -name pip

sudo touch ~/.bashrc

echo 'alias pip="~/.oh-my-zsh/plugins/pip"' >> ~/.bashrc

sudo apt install python3-pip

source ~/.bashrc

pip --version

pip install powerline-status

pip show powerline-status

pip install psutil i3ipc

touch ./vimrc

echo '
set laststatus=2           " Always display the status bar
set powerline_cmd="py3"    " Tell powerline to use Python 3
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
' >> ~/.vimrc