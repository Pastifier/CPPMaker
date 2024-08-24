#!/bin/bash

# Prompt the user for the project name, exercise number, and program name
read -p "Would you like to create a project directory? [y/n]: " project_answer
if [ "$project_answer" == "y" ]; then
	read -p "Enter the project name: " project_name
	mkdir -p $project_name
	cd $project_name
fi

read -p "Would you like to create an exercise directory? [y/n]: " exercise_answer
if [ "$exercise_answer" == "y" ]; then
	read -p "Enter the exercise: " exercise
	if [ "$project_answer" == "n" ]; then
		read -p "Would you like to create the exercise directory in current directory? [y/n]: " answer
		if [ "$answer" == "n" ]; then
			read -p "Enter the path to the exercise directory: " path
			cd $path
		fi
	fi
	mkdir -p $exercise
	cd $exercise
fi

read -p "Enter the program name: " program_name

# Prompt the user for the source files
read -p "Enter the source files (space-separated, excluding \`main.cpp\`): " source_files
read -p "Would you like to create header-files associated with the source files? (y/n): " answer
read -p "Would you like to create a main.cpp file (with simple boiler-plate)? [y/n]: " main_answer
read -p "Would you like to include valgrind support in the Makefile? [y/n]: " valgrind_answer

INCLUDES=""

if [ "$answer" == "y" ]; then
	for file in $source_files; do
        header_file="${file%.cpp}.hpp"
        touch "$header_file"
    done
	INCLUDES+="INCLUDES := \$(SRC:.cpp=.hpp)";
fi

if [ "$main_answer" == "y" ]; then
	source_files+=" main.cpp"
fi

# Create the source_files
touch $source_files

# Create the Makefile
cat <<EOF > Makefile
# Program
NAME := $program_name

# Necessities
CXX := c++
CXXFLAGS := -Wall -Wextra -Werror -std=c++98

#Colors:
GREEN		=	\e[92;5;118m
YELLOW		=	\e[93;5;226m
GRAY		=	\e[33;2;37m
RESET		=	\e[0m
CURSIVE		=	\e[33;3m

# Targets
SRC := $source_files
$INCLUDES

# Rules
all: \$(NAME)

\$(NAME): \$(SRC)
	\$(CXX) -o \$@ \$(CXXFLAGS) \$(SRC)
	@printf "\$(GREEN)Compilation successful!\$(RESET)\n"

clean:
	rm -rf \$(NAME)
	@printf "\$(YELLOW)Executable removed.\$(RESET)\n"
 
EOF

ifeq [ "$valgrind_answer" == "y" ]; then
	cat <<EOF >> Makefile
valgrind:
	@printf "\$(CURSIVE)Running valgrind...\$(RESET)\n"
	valgrind --leak-check=full ./\$(NAME)
endif

EOF

cat <<EOF >> Makefile
re: clean all

.PHONY: all clean re
EOF

printf "Makefile generated successfully."


if [ "$main_answer" == "y" ]; then
	cat<<EOF > main.cpp
#include <iostream>

int main(void) {
	std::cout << "Hello, world!" << std::endl;

	return 0;
}

EOF
fi
