CC      = gcc
CFLAGS  = -Wall -Wextra -std=c99

NAME    = __NAME__
SRCDIR  = src
SRC     = $(wildcard $(SRCDIR)/*.c)
OBJ     = $(SRC:.c=.o)

all:	$(NAME)

$(NAME):	$(OBJ)
	$(CC) $(OBJ) -o $(NAME)

$(SRCDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
