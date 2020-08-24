# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kcorazon <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/05/10 10:09:59 by kcorazon          #+#    #+#              #
#    Updated: 2020/05/10 11:24:33 by kcorazon         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME 		= libft.a
NAME_SO		= libft.so

#===============================================================================

OBJ_DIR     = obj/
HDR_DIR     = includes/
HEAD 		= $(addprefix $(HDR_DIR), libft.h)

#===============================================================================

CC 			= gcc
CFLAGS		= -Wall -Wextra -Werror

#===============================================================================

CHAR_DIR    = char/
CHAR_SRC    = ft_isalnum.c      ft_isalpha.c        ft_isascii.c               \
              ft_isdigit.c      ft_isprint.c        ft_tolower.c               \
              ft_toupper.c
CHAR_OBJ    = $(addprefix $(OBJ_DIR), $(CHAR_SRC:.c=.o))

#-------------------------------------------------------------------------------

LIST_DIR    = list/
LIST_SRC    = ft_lstadd_back.c  ft_lstadd_front.c   ft_lstclear.c              \
              ft_lstdelone.c    ft_lstiter.c        ft_lstlast.c               \
              ft_lstmap.c       ft_lstnew.c         ft_lstsize.c
LIST_OBJ    = $(addprefix $(OBJ_DIR), $(LIST_SRC:.c=.o))

#-------------------------------------------------------------------------------

MEM_DIR     = mem/
MEM_SRC     = ft_bzero.c        ft_calloc.c         ft_memccpy.c               \
              ft_memchr.c       ft_memcmp.c         ft_memcpy.c                \
              ft_memmove.c      ft_memset.c
MEM_OBJ     = $(addprefix $(OBJ_DIR), $(MEM_SRC:.c=.o))

#-------------------------------------------------------------------------------

OUT_DIR     = out/
OUT_SRC     = ft_putchar_fd.c   ft_putendl_fd.c     ft_putnbr_fd.c             \
              ft_putstr_fd.c
OUT_OBJ     = $(addprefix $(OBJ_DIR), $(OUT_SRC:.c=.o))

#-------------------------------------------------------------------------------

STR_DIR     = str/
STR_SRC     = ft_atoi.c         ft_itoa.c           ft_split.c                 \
              ft_strchr.c       ft_strdup.c         ft_strjoin.c               \
              ft_strlcat.c      ft_strlcpy.c        ft_strlen.c                \
              ft_strmapi.c      ft_strncmp.c        ft_strnstr.c               \
              ft_strrchr.c      ft_strtrim.c        ft_substr.c
STR_OBJ     = $(addprefix $(OBJ_DIR), $(STR_SRC:.c=.o))

#===============================================================================

OBJ			= $(CHAR_OBJ) $(LIST_OBJ) $(MEM_OBJ) $(OUT_OBJ) $(STR_OBJ)

#===============================================================================

.PHONY: all
all: $(NAME)

$(NAME): $(OBJ_DIR) objs
		@ar rcs $(NAME) $(OBJ)
		@ranlib $(NAME)

$(OBJ_DIR):
		@mkdir $(OBJ_DIR)

#-------------------------------------------------------------------------------

.PHONY: objs
objs: $(CHAR_OBJ) $(LIST_OBJ) $(MEM_OBJ) $(OUT_OBJ) $(STR_OBJ)

$(CHAR_OBJ): $(OBJ_DIR)%.o: $(CHAR_DIR)%.c $(HEAD)
		$(CC) -I $(HDR_DIR) $(FLAGS) -c $< -o $@

$(LIST_OBJ): $(OBJ_DIR)%.o: $(LIST_DIR)%.c $(HEAD)
		$(CC) -I $(HDR_DIR) $(FLAGS) -c $< -o $@

$(MEM_OBJ): $(OBJ_DIR)%.o: $(MEM_DIR)%.c $(HEAD)
		$(CC) -I $(HDR_DIR) $(FLAGS) -c $< -o $@

$(OUT_OBJ): $(OBJ_DIR)%.o: $(OUT_DIR)%.c $(HEAD)
		$(CC) -I $(HDR_DIR) $(FLAGS) -c $< -o $@

$(STR_OBJ): $(OBJ_DIR)%.o: $(STR_DIR)%.c $(HEAD)
		$(CC) -I $(HDR_DIR) $(FLAGS) -c $< -o $@

#===============================================================================

.PHONY: so
so: $(NAME_SO)

$(NAME_SO): $(OBJ) $(OBJ_BONUS)
		$(CC) -shared -o $(NAME_SO) $(OBJ) $(OBJ_BONUS)

#===============================================================================

.PHONY: clean
clean:
		rm -f $(OBJ) $(OBJ_BONUS)

#-------------------------------------------------------------------------------

.PHONY: fclean
fclean: clean
		rm -f $(NAME) $(NAME_SO)

#-------------------------------------------------------------------------------

.PHONY: re
re: fclean all

#===============================================================================
