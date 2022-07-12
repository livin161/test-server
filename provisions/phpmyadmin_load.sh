echo "Установка phpmyadmin"

sudo apt -y install php-mbstring

sudo apt -y install phpmyadmin

sudo apt install mysql-server mysql-client

echo "Осталось выполнить инструкции в скрипте ниже"

#sudo mysql -u root -p
#CREATE USER 'test'@'localhost' IDENTIFIED BY 'пароль';
#GRANT ALL PRIVILEGES ON *.* TO 'test'@'localhost';
#FLUSH PRIVILEGES;