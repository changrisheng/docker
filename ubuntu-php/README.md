# Docker guideline
1. Install Docker Toolbox
	- Mac: https://docs.docker.com/mac/
	- Linux: https://docs.docker.com/linux/
	- Windows: https://docs.docker.com/windows/

2. Run default docker machine: `docker-machine start default`
	```Bash
    docker-machine start default #maybe need to restart
    docker-machine env
    eval "$(docker-machine env)"
	```

3. Pull the built image:
	```Bash
    docker pull hhxsv5/ubuntu-php
	```
    Or build image by Dockerfile:
    ```Bash
    #Download the dockerfile: https://raw.githubusercontent.com/hhxsv5/docker/master/Dockerfile
    #Make sure the file name must be "Dockerfile"
    #cd to Dockerfile directory and run the following command.
    #Or you can specify the Dockerfile path by -f param.
    docker build -t hhxsv5/ubuntu-php:latest .
	```

4. Generate containner:
	```Bash
    #You will get a ssh terminal, just exit it
    docker run -it --name ubuntu-php -p 80:80 -p 443:443 -p 3306:3306 -p 11211:11211 -p 6379:6379 -v ~/Documents/www:/home/www hhxsv5/ubuntu-php:latest sh -c '/root/start.sh && /bin/bash'
	```

5. Start containner:
	```Bash
    docker start -i ubuntu-php
	```
    
6. Do some customized configurations, nginx vhost,mysql,redis,memcached, etc.
7. Note: bind-address cannot be 127.0.0.1. For mysql: /etc/mysql/my.cnf, otherwise cannot connect.
8. More docs: http://docs.daocloud.io/faq/docker101