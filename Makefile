NAME     ?= project
CC       ?= cc
CFLAGS   ?= -Wall -Wextra -Werror -std=gnu99 -pedantic
CPPFLAGS += -Iinclude -MMD -MP
SAN      :=

SRC_DIR  := src
OBJ_DIR  := build
SRC      := $(wildcard $(SRC_DIR)/*.c)
OBJ      := $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
DEP      := $(OBJ:.o=.d)

all: 		$(NAME)

$(NAME): 		$(OBJ)
				$(CC) $(CFLAGS) $(SAN) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
				@mkdir -p $(@D)
				$(CC) $(CPPFLAGS) $(CFLAGS) $(SAN) -c $< -o $@

-include $(DEP)

debug: 			SAN := -fsanitize=address -g
debug: 			fclean $(NAME)

clean:
				rm -rf $(OBJ_DIR)

fclean: 		clean
				rm -f $(NAME)

re: 			fclean all

setup:
				git config core.hooksPath .githooks

.PHONY: all debug clean fclean re setup
