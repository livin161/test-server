clear

echo "Начинаю запуск установщика файлов для работы тачки"

echo "Устанавливаю vim"

sudo apt-get install vim

echo "А теперь пошли по более масштабным настройкам"

bash nginx_load.sh

echo "Олично, теперь пора установить node.js"

bash node_load.sh

