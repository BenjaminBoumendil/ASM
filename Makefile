NAME			=	libfts.a
LIB_NAME		=	fts
SRC_DIR			=	srcs
SRC				=	ft_bzero.s		\
					ft_puts.s		\
					ft_isalpha.s	\
					ft_isdigit.s	\
					ft_isalnum.s	\
					ft_strlen.s		\
					ft_toupper.s 	\
					ft_tolower.s	\
					ft_memset.s		\
					ft_memcpy.s		\
					ft_strdup.s		\
					ft_strcat.s		\
					ft_isascii.s	\
					ft_memset.s		\
					ft_isprint.s	\
					ft_isascii.s	\
					ft_cat.s		\
					ft_strcpy.s 	\
					ft_memccpy.s	\
					ft_memdel.s
OBJ_DIR			=	objs
OBJ				=	$(addprefix $(OBJ_DIR)/, $(notdir $(SRC:.s=.o)))

TESTS_NAME		=	libfts_tests
TESTS_SRC_DIR	=	tests
TESTS_SRC		=	main.cpp			\
					simple/bzero.cpp	\
					simple/puts.cpp		\
					simple/isalpha.cpp	\
					simple/strcat.cpp	\
					simple/isascii.cpp	\
					simple/isdigit.cpp	\
					simple/isalnum.cpp	\
					simple/isprint.cpp	\
					simple/tolower.cpp	\
					simple/toupper.cpp	\
					medium/strdup.cpp	\
					medium/memcpy.cpp	\
					medium/strlen.cpp	\
					medium/memset.cpp	\
					hard/cat.cpp		\
					bonus/strcpy.cpp	\
					bonus/memccpy.cpp	\
					bonus/memdel.cpp
TESTS_OBJ		=	$(addprefix $(OBJ_DIR)/, $(notdir $(TESTS_SRC:.cpp=.o)))

COMPILER		=	g++
CFLAGS			=	-Wall -Wextra -Werror -O3 -std=c++1y -c
LFLAGS			=	-L. -l$(LIB_NAME)


all: $(NAME)

$(NAME): $(OBJ)
	ar rc $@ $^
	ranlib $@

$(OBJ): | $(OBJ_DIR)

$(OBJ_DIR):
	mkdir -p $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	nasm -f macho64 $< -o $@

tests: $(NAME) $(TESTS_NAME)

$(TESTS_NAME): $(TESTS_OBJ)
	$(COMPILER) $(LFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(TESTS_SRC_DIR)/%.cpp
	$(COMPILER) $(CFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(TESTS_SRC_DIR)/simple/%.cpp
	$(COMPILER) $(CFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(TESTS_SRC_DIR)/medium/%.cpp
	$(COMPILER) $(CFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(TESTS_SRC_DIR)/hard/%.cpp
	$(COMPILER) $(CFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(TESTS_SRC_DIR)/bonus/%.cpp
	$(COMPILER) $(CFLAGS) $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)
	rm -f $(TESTS_NAME)

re: fclean all
