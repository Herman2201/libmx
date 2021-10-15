SRC_DIR := src
OBJ_DIR := obj

EXE := libmx.a
SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

CC=clang
CPPFLAGS=-Iinc -MMD -MP
CFLAGS=-std=c11 -Wall -Wextra -Werror -Wpedantic

all: $(EXE)

$(EXE): $(OBJ)
	@$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@
	@printf "\r\33[2K$@\t   \033[32;1mcreated\033[0m\n"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

	@printf "\r\33[2K$(NAME)\t   \033[33;1mcompile \033[0m$(<:$(SRCD)/%.c=%) "

$(OBJ_DIR):
	@mkdir -p $@

uninstall: clean
	@$(RM) -v $(EXE)
	@printf "$(EXE)\t   \033[31;1muninstalled\033[0m\n"

clean:
	@$(RM) -rv $(OBJ_DIR)
	@printf "$(OBJ_DIR)\t   \033[31;1mdeleted\033[0m\n"

-include $(OBJ:.o=.d)

reinstall: uninstall all

