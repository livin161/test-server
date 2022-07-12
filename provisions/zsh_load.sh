sudo apt update

sudo apt install zsh
sudo apt install powerline fonts-powerline

sudo git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

sudo cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
sudo mv zsh-syntax-highlighting ~/.oh-my-zsh/plugins

source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

echo 'source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh' >> ~/.zshrc

echo 'ZSH_THEME="agnoster"' >> ~/.zshrc
# После установки попадаем в файл конфигурации и ставим это
# ZSH_THEME="agnoster"
#Устанавлвиваем шрифты и ставим их на оригинальный комп (не на тачку) и в шрифтах консоли ставим их (либо из списка)
# wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
#fc-cache -f -v

