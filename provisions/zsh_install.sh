echo "Установка ZSH"

sudo apt update

sudo apt install zsh
sudo apt install powerline fonts-powerline

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

nano ~/.zshrc

# После установки попадаем в файл конфигурации и ставим это
# ZSH_THEME="agnoster"
#Устанавлвиваем шрифты и ставим их на оригинальный комп (не на тачку) и в шрифтах консоли ставим их (либо из списка)
# wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
#fc-cache -f -v

