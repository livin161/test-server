function installNginx() {
    nginxInstalled=`sudo service nginx status`

    if [[ "$nginxInstalled" == *"active (running)"* ]]; then
      echo "nginx установлен и акивно работает"

      return
    fi

    if [[ "$nginxInstalled" == *"inactive (dead)"* ]]; then
      echo "nginx установлен, но деактивирован"

      return
    fi

    if [[ "$nginxInstalled" == *"failed (Result: exit-code)"* ]]; then
      echo "nginx установлен, но есть ошибка"

      return
    fi

    echo "Идёт установка пакетов для работы с NGINX: ";

    sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring

    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \ | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

    gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

    sudo apt update
    sudo apt install nginx

    sudo chmod 777 /etc/nginx/*


echo "user vagrant;
worker_processes 2;
timer_resolution 100ms;
worker_rlimit_nofile 131072;
worker_priority -5;
pid /run/nginx.pid;
events {
    worker_connections 16384;
    multi_accept on;
    use epoll;
}
http {
    ##
    # Basic Settings
    ##

    sendfile on;
    disable_symlinks off;
    tcp_nopush on;
    tcp_nodelay on;
    types_hash_max_size 2048;
    server_tokens off;
    expires off;

    client_max_body_size 32M;
    client_body_buffer_size 10K;
    client_header_buffer_size 1k;
    large_client_header_buffers 4 8k;

    client_body_timeout 12;
    client_header_timeout 12;
    keepalive_timeout 40;
    keepalive_requests 100;
    send_timeout 20;
    reset_timedout_connection on;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # Logging Settings
    ##

    #access_log /var/log/nginx/access.log;
    #error_log /var/log/nginx/error.log;
    access_log off;

    # Caches information about open FDs, freqently accessed files.
    open_file_cache max=200000 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 2;
    open_file_cache_errors on;

    ##
    # Gzip Settings
    ##
    gzip on;
    gzip_proxied any;
    gzip_comp_level 3;
    gzip_static on;
    gzip_types
    text/css
    text/plain
    text/json
    text/x-js
    text/javascript
    text/xml
    application/json
    application/x-javascript
    application/xml
    application/xml+rss
    application/javascript
    application/x-font-ttf
    application/x-font-opentype
    application/vnd.ms-fontobject
    image/svg+xml
    image/x-icon
    application/atom_xml;
    gzip_min_length 1024;
    gzip_disable \"msie6\";
    gzip_vary on;

    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}" | sudo tee /etc/nginx/nginx.conf

read -d '' NGINX_SITE <<EOF
server {
     	listen 80 default_server;
     	listen [::]:80 default_server;
     	server_name dev-test.ru;

     	error_log /var/log/nginx/dev-test.error.log error;

     	root /home/testCar/projects/public/;

      index index.php index.html index.htm index.nginx-debian.html;

      server_name dev-test.ru;

      location / {
          try_files \$uri \$uri/ =404;
      }

      # Работаем через TCP/IP, потому что UNIX не хочет находить файлы
      location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
      }
}
EOF

# Create site & enable it
echo "${NGINX_SITE}" > /etc/nginx/sites-available/default

read -d '' NGINX_SITE <<EOF
server {
	listen 90 default_server;
	listen [::]:90 default_server;

	add_header 'Access-Control-Allow-Origin' '*' always;
  add_header 'Access-Control-Allow-Credentials' 'true' always;
  add_header 'Access-Control-Allow-Methods' 'GET, POST' always;
  add_header 'Access-Control-Allow-Headers' 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type' always;

	root /usr/share/phpmyadmin/;

	server_name dev-phpmyadmin.ru;

	access_log  /var/log/nginx/phpmy-access.log; #расположение логов данного хоста
  error_log   /var/log/nginx/phpmy-error.log;

	index index.php index.html index.htm index.nginx-debian.html;

	location /phpmyadmin {
		location ~ \.php$ {
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_index index.php;
			fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
			include /etc/nginx/fastcgi_params;
			fastcgi_ignore_client_abort off;
		}
	}

	location ~ \.php {
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
		include /etc/nginx/fastcgi_params;
	}
}
EOF

echo "${NGINX_SITE}" > /etc/nginx/sites-available/phpmyadmin

read -d '' NGINX_SITE <<EOF
server {
	listen 100 default_server;
	listen [::]:100 default_server;

	server_name vanila_tools.ru;

	root /home/testCar/projects/public/vanila_tools;

	index index.php;

  client_max_body_size 5M;

  access_log  /var/log/nginx/access-vanila-site.log;
	error_log   /var/log/nginx/error-vanila-site.log;

	error_page  405 =200 $uri;
        location ~ \.php$ {
                fastcgi_pass   127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param  SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
                include        /etc/nginx/fastcgi_params;
       }
}
EOF

echo "${NGINX_SITE}" > /etc/nginx/sites-available/vanilaTools

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/phpmyadmin
ln -sf /etc/nginx/sites-available/vanilaTools /etc/nginx/sites-enabled/vanilaTools
}

installNginx