# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anonymous <anonymous@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/08 14:31:20 by anonymous         #+#    #+#              #
#    Updated: 2023/02/14 12:15:09 by anonymous        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all:
	@mkdir -p /home/jvigneau/data/mariadb
	@mkdir -p /home/jvigneau/data/wordpress
	@docker-compose -f docker-compose.yml up --build

up:
	@docker-compose -f scrs/docker-compose.yml up

down:
	@docker-compose -f scrs/docker-compose.yml down

build:
	@docker-compose -f scrs/docker-compose.yml build

clean:
	rm -rf /home/jvigneau/data/mariadb
	rm -rf /home/jvigneau/data/wordpress
	@docker-compose scrs/docker-compose.yml down --rmi all

clean-volume:
	@docker volume rm $(shell docker volume ls -q)

fclean : clean clean-volume

re : fclean all

.PHONY : all up down build clean clean-volume fclean re