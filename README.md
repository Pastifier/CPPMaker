# CPPMaker
A very simple bash-script, generating a full-on directory in compliance with the 42-CPP projects (cuz I'm lazy).
This script streamlines the creation of the 42 C++ projects, exercises, source files, and a `Makefile` with customizable options. It's perfect for setting up a structured project environment with minimal effort.

---

## Features ✨

- 📁 **Project Directory Creation**: Optionally create a project folder and navigate into it.
- 📂 **Exercise Directory Creation**: Organize exercises in separate directories.
- 📝 **Source File and Header File Setup**: Automatically generate `.cpp` and optional `.hpp` files for your sources.
- 🔨 **`Makefile` Generation**: Create a `Makefile` with:
  - Compilation rules.
  - Support for `main.cpp` boilerplate.
  - Optional Valgrind support.
  - Clean and rebuild commands.
- 👋 **Boilerplate `main.cpp`**: Generate a `main.cpp` file with a simple "Hello, World!" example.

---

## How It Works 🚀

1. **Run the Script**: Execute the script in your terminal.
2. **Follow Prompts**:
   - Decide whether to create a project or exercise directory.
   - Provide the project/exercise name.
   - Specify source file names and whether to generate corresponding headers.
   - Optionally generate a `main.cpp` boilerplate.
   - Include Valgrind support if needed.
3. **Files Generated**:
   - `.cpp` and `.hpp` files as per your input.
   - A comprehensive `Makefile` tailored to your needs.
   - Optional `main.cpp` with a basic example.

---

## Prerequisites 📋

- A Unix-based shell (Linux or macOS).
- `bash` installed.

---

## Usage 🛠️

1. Save the script to a file, e.g., `setup_project.sh`.
2. Make it executable:
```bash
chmod +x setup_project.sh
```
3. Run the script:
```bash
./setup_project.sh
```
4. Optionally, set an alias for it in your `.*rc` file.
```bash
# ~/.bashrc
alias 42cppgen path/to/the/script
```

---

## Example Output 📂

### Input:
- Project name: `MyProject`
- Exercise: `ex00`
- Source files: `file1.cpp file2.cpp`
- Generate headers: Yes
- Add `main.cpp`: Yes
- Include Valgrind support: Yes

### Output:
#### Directory Structure:
```
MyProject/
└── ex00/
    ├── file1.cpp
    ├── file1.hpp
    ├── file2.cpp
    ├── file2.hpp
    ├── main.cpp
    └── Makefile
```

#### Makefile Contents (Simplified):
```makefile
# Program
NAME := MyProgram

# Necessities
CXX := c++
CXXFLAGS := -Wall -Wextra -Werror -std=c++98

# Targets
SRC := file1.cpp file2.cpp main.cpp
INCLUDES := $(SRC:.cpp=.hpp)

# Rules
all: $(NAME)

$(NAME): $(SRC)
	$(CXX) -o $@ $(CXXFLAGS) $(SRC)
	@printf "\e[92;5;118mCompilation successful!\e[0m\n"

clean:
	rm -rf $(NAME)
	@printf "\e[93;5;226mExecutable removed.\e[0m\n"

valgrind:
	@printf "\e[33;3mRunning valgrind...\e[0m\n"
	valgrind --leak-check=full ./$(NAME)

re: clean all

.PHONY: all clean re
```

#### `main.cpp` Contents:
```cpp
#include <iostream>

int main(void) {
	std::cout << "Hello, world!" << std::endl;

	return 0;
}
```

---

## Notes 📒

- This script is interactive, prompting you for inputs at each step.
- It’s highly customizable for your specific project needs.
- Use this tool to focus on coding, not setup!

---
