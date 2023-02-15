# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jvigneau <jvigneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/15 09:06:52 by jvigneau          #+#    #+#              #
#    Updated: 2023/02/15 09:11:50 by jvigneau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	sudo mkdir -p /home/jvigneau/data/mariadb
	sudo mkdir -p /home/jvigneau/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yml up --build

clean:
	sudo rm -rf /home/jvigneau/data/mariadb
	sudo rm -rf /home/jvigneau/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yml down --rmi all

volume-clean:
	sudo docker volume rm $(shell docker volume ls -q)

fclean: clean volume-clean

re: fclean all

.PHONY: all clean volume-clean fclean re