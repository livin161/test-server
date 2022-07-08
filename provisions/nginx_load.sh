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

echo "
  user www-data;
  worker_processes auto;
  pid /run/nginx.pid;
  include /etc/nginx/modules-enabled/*.conf;

  events {
  	worker_connections 1024;
  	# multi_accept on;
  }

  http {
  	##
  	# Basic Settings
  	##

  	sendfile on;
  	tcp_nopush on;
  	tcp_nodelay on;
  	keepalive_timeout 65;
  	types_hash_max_size 2048;
  	# server_tokens off;

  	client_max_body_size 5M;

  	# server_names_hash_bucket_size 64;
  	# server_name_in_redirect off;

  	include /etc/nginx/mime.types;
  	default_type application/octet-stream;

  	##
  	# SSL Settings
  	##

  	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
  	ssl_prefer_server_ciphers on;

  	##
  	# Logging Settings
  	##

  	access_log /var/log/nginx/access.log;
  	error_log /var/log/nginx/error.log;

  	##
  	# Gzip Settings
  	##

  	gzip on;

  	# gzip_vary on;
  	# gzip_proxied any;
  	# gzip_comp_level 6;
  	# gzip_buffers 16 8k;
  	# gzip_http_version 1.1;
  	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

  	##
  	# Virtual Host Configs
  	##

  	include /etc/nginx/conf.d/*.conf;
  	include /etc/nginx/sites-enabled/*;
  }
" > /etc/nginx/nginx.conf

    echo "
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
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
      }
}
          " > /etc/nginx/sites-enabled/default

echo "
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
			add_header "Access-Control-Allow-Origin"  *;

			fastcgi_pass 127.0.0.1:9000;
			fastcgi_index index.php;
			fastcgi_param SCRIPT_FILENAME $request_filename;
			include fastcgi_params;
			fastcgi_ignore_client_abort off;
		}
	}

	location ~ \.php {
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	}
}
" > /etc/nginx/sites-available/phpmyadmin.conf

echo "
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
			add_header "Access-Control-Allow-Origin"  *;

			fastcgi_pass 127.0.0.1:9000;
			fastcgi_index index.php;
			fastcgi_param SCRIPT_FILENAME $request_filename;
			include fastcgi_params;
			fastcgi_ignore_client_abort off;
		}
	}

	location ~ \.php {
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	}
}
" > /etc/nginx/sites-available/phpmyadmin.conf

echo "
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
                fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
                include        fastcgi_params;
       }
}
" > /etc/nginx/sites-available/vanilaTools.conf

}
installNginx