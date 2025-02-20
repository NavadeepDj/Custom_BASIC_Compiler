

# 🖥️ **Custom_BASIC_Compiler**  
A simple **BASIC Compiler** built using **Flex (Lexical Analysis) and Bison (Parsing)**.  
This project is created for **learning purposes**, supporting a **small subset of the BASIC language**.  

---

## 📌 **Getting Started**  

### 🚀 **Clone the Repository**  
```sh
git clone https://github.com/your-username/Custom_BASIC_Compiler.git
cd Custom_BASIC_Compiler
```

## 📝 **What This Compiler Can Do?**  
✔ Supports **Variable Assignments** (`LET X = 10`)  
✔ Supports **Print Statements** (`PRINT X` and `PRINT "Hello, World!"`)  
✔ Converts BASIC code into **C code (`output.c`)**, which can be compiled with `gcc`  

---

## 🔧 **How to Use?**  

### 🛠 **Step 1: Install Dependencies**  
Make sure you have **Flex, Bison, and GCC** installed.  

### 🏃 **Step 2: Build the Compiler**  
```sh
cd src
bison -d parser/syntax.y
flex lexer/lexical.l
gcc parser/syntax.tab.c lex.yy.c -o basic_compiler
```

### 📜 **Step 3: Compile a BASIC File**
Write a BASIC program (`examples/input.bas`):  
```basic
LET X = 10
PRINT X
PRINT "Hello, BASIC!"
```

Run the compiler:  
```sh
./basic_compiler < examples/input.bas
```

This generates a C file (`output.c`):  
```c
#include <stdio.h>
int main() {
    int X = 10;
    printf("%d\n", X);
    printf("%s\n", "Hello, BASIC!");
    return 0;
}
```

Compile the generated C file:
```sh
gcc output.c -o program
./program
```

Expected Output:
```sh
10
Hello, BASIC!
```

---

## 🤝 **Want to Contribute?**  
🔹 **Fork the Repository**  
🔹 **Make your changes** (add new features or optimize code)  
🔹 **Create a Pull Request (PR)**  

```sh
git fork https://github.com/your-username/Custom_BASIC_Compiler.git
git clone https://github.com/your-username/Custom_BASIC_Compiler.git
```

Thank you alllllll!!!
