# Simple Lexer for a Mini Language

## Introduction
This project implements a simple lexer (lexical analyzer) using **Flex**. The lexer recognizes basic tokens such as **keywords (LET, PRINT)**, **identifiers (X, Y, etc.)**, **numbers (10, 20, etc.)**, **operators (=, +, -, *, /)**, and **whitespace**. It processes input and categorizes each token accordingly.

## Prerequisites
Before running the lexer, ensure you have:
- **Flex** installed
- **GCC** compiler installed
- A terminal (Linux/macOS) or a command prompt with MinGW (Windows)

To check if Flex is installed, run:
```sh
flex --version
```
If not installed, you can install it using:
- **Linux (Ubuntu/Debian)**: `sudo apt install flex`
- **MacOS**: `brew install flex`
- **Windows**: Install Flex via Cygwin or MinGW

## Lexer Code
Save the following code as `lexical.l`:

```c
%{
#include <stdio.h>
%}

/* Define token patterns */
%%
"LET"       { printf("TOKEN: LET\n"); }
"PRINT"     { printf("TOKEN: PRINT\n"); }
[A-Z]       { printf("TOKEN: IDENTIFIER (%s)\n", yytext); }
[0-9]+      { printf("TOKEN: NUMBER (%s)\n", yytext); }
[=+\-*/]    { printf("TOKEN: OPERATOR (%s)\n", yytext); }
[ \t\n]     { /* Ignore whitespace */ }
.           { printf("UNKNOWN TOKEN: %s\n", yytext); }
%%

int main() {
    yylex();  // Start lexing
    return 0;
}

int yywrap() { return 1; }
```

## Compilation and Execution
Follow these steps to compile and run the lexer:

### Step 1: Generate the Lexical Analyzer
```sh
flex lexical.l
```
This generates a `lex.yy.c` file, which contains the C code for the lexer.

### Step 2: Compile the Lexer
```sh
gcc lex.yy.c -o lexer
```
This compiles the lexer and produces an executable `lexer` (or `lexer.exe` on Windows).

### Step 3: Run the Lexer
```sh
./lexer
```
Now, you can enter a sample input. Type the following and press **Ctrl+D** (Linux/macOS) or **Ctrl+Z** (Windows) to end input:

#### Sample Input:
```
LET X = 10
PRINT X
```

#### Expected Output:
```
TOKEN: LET
TOKEN: IDENTIFIER (X)
TOKEN: OPERATOR (=)
TOKEN: NUMBER (10)
TOKEN: PRINT
TOKEN: IDENTIFIER (X)
```

## Explanation of Tokens
- `LET` and `PRINT`  **Keywords**
- `X`  **Identifier**
- `=`  **Operator**
- `10`  **Number**
- Whitespace is ignored

## Customization
You can extend this lexer by adding more keywords, operators, or special characters. For example, adding a **semicolon (;)** as a statement terminator:
```c
";"   { printf("TOKEN: SEMICOLON\n"); }
```

