# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: zhlim <zhlim@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/12 21:38:43 by zhlim             #+#    #+#              #
#    Updated: 2024/01/12 21:56:43 by zhlim            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS				= $(addprefix $(SRCSDIR)/, $(addsuffix .c, execve))

OBJS				= $(patsubst $(SRCSDIR)/%.c, $(OBJSDIR)/%.o, $(SRCS))

SRCSDIR				= src
OBJSDIR				= build

CC					= gcc
CFLAGS				= -Wall -Werror -Wextra #-g

RM					= rm -rf

INCLUDES			= -Iincludes -Ilibft -Ilibft/ft_printf/include/ -Ilibft/get_next_line

NAME				= minishell

LIBFT				= libft/libft.a
LIBFTFLAGS			= -Llibft/ -lft
LIBPRINTF			= libft/ft_printf/libftprintf.a
LIBPRINTFFLAGS		= -Llibft/ft_printf -lftprintf

$(OBJSDIR)/%.o:		$(SRCSDIR)/%.c | $(OBJSDIR)
					$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

all:				$(NAME) 

$(NAME):			$(OBJS)
					$(CC) $(CFLAGS) $^ $(LIBFTFLAGS) $(LIBPRINTFFLAGS) -o $@

$(OBJS):			$(LIBFT) $(LIBPRINTF)

$(OBJSDIR):		
					mkdir -p $(OBJSDIR)

$(LIBFT):		
					make bonus -C libft/

$(LIBPRINTF):	
					make -C libft/ft_printf/

clean:		
					$(RM) $(OBJSDIR)
					make clean -C libft/
					make clean -C libft/ft_printf/
				
fclean:				clean
					$(RM) $(NAME)
					make fclean -C libft/
					make fclean -C libft/ft_printf/

re:					fclean all

.PHONY:				all clean fclean re bonus