# BASIC Compiler (Subset)

This is a simple compiler for a **subset of BASIC**, built using **Flex** (Lexer) and **Bison** (Parser).  
It converts BASIC code into **C code**, which can then be compiled and executed.  

## 🚀 Features
✅ Supports **Variable Assignment** (`LET X = 10`)  
✅ Supports **Print Statements** (`PRINT X`)  
✅ Generates a C program (`output.c`)  

---

Here’s a **step-by-step README** for your GitHub repository, detailing everything from modifying `syntax.y` to compiling the final executable. 🚀  

---

# 📜 **BASIC Compiler (Subset)**
This is a simple **BASIC compiler** that converts a subset of BASIC into **C code** using **Flex (Lexer) and Bison (Parser)**.  
After generating C code (`output.c`), you can compile it using `gcc` to create an executable.  

## 🎯 **Features**
✅ Supports **Variable Assignments** (`LET X = 10`)  
✅ Supports **Print Statements** (`PRINT X`)  
✅ Outputs a valid **C program** (`output.c`)  

---

## 🛠 **Step 1: Install Dependencies**
Before starting, make sure you have **Flex, Bison, and GCC** installed.  

## 📝 **Step 2: Modify `syntax.y` (Bison Parser)**
### **Why?**
- `syntax.y` defines the grammar rules for parsing BASIC code.
- We need to generate C code instead of executing it immediately.

### **Changes in `syntax.y`:**
```yacc
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *outputFile; // File to store generated C code

void yyerror(const char *s);
int yylex();
%}

%union {
    char varname[100];
}

%token PRINT LET NUMBER VARIABLE EQUALS STRING

%%

program:
    program statement '\n'
    | statement '\n'
    ;

statement:
    PRINT VARIABLE {
        fprintf(outputFile, "printf(\"%%d\\n\", %s);\n", $2);
    }
    | PRINT STRING {
        fprintf(outputFile, "printf(\"%%s\\n\", %s);\n", $2);
    }
    | LET VARIABLE EQUALS NUMBER {
        fprintf(outputFile, "int %s = %d;\n", $2, $4);
    }
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    outputFile = fopen("output.c", "w");
    fprintf(outputFile, "#include <stdio.h>\nint main() {\n");

    yyparse();

    fprintf(outputFile, "return 0;\n}\n");
    fclose(outputFile);
    return 0;
}
```

---

## 📝 **Step 3: Modify `lexical.l` (Flex Lexer)**
### **Why?**
- `lexical.l` tokenizes the input and passes it to Bison.

### **Changes in `lexical.l`:**
```lex
%{
#include "syntax.tab.h"
%}

%%

[ \t]+           ;  // Ignore spaces and tabs
\n              return '\n';
"PRINT"         return PRINT;
"LET"           return LET;
"="             return EQUALS;
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[A-Za-z][A-Za-z0-9]* { strcpy(yylval.varname, yytext); return VARIABLE; }
\"[^\"]*\"      { strcpy(yylval.varname, yytext); return STRING; }

.               printf("Unrecognized character: %s\n", yytext);

%%
```

---

## 🔄 **Step 4: Generate the Parser and Lexer**
After modifying `syntax.y` and `lexical.l`, run the following commands:

```sh
bison -d syntax.y
flex lexical.l
gcc syntax.tab.c lex.yy.c -o basic_compiler
```

This will generate:
- `syntax.tab.c` (Parser)
- `syntax.tab.h` (Header file for tokens)
- `lex.yy.c` (Lexer)
- `basic_compiler` (Executable)

---

## 🏃‍♂️ **Step 5: Run the Compiler**
### **Example Input File (`input.bas`)**
```basic
LET X = 10
PRINT X
PRINT "Hello, BASIC!"
```

Run the compiler:
```sh
./basic_compiler < input.bas
```

This generates `output.c`:
```c
#include <stdio.h>
int main() {
    int X = 10;
    printf("%d\n", X);
    printf("%s\n", "Hello, BASIC!");
    return 0;
}
```

---

## 🔨 **Step 6: Compile the Generated C Code**
Now, compile the `output.c` file:
```sh
gcc output.c -o program
```

Run the final executable:
```sh
./program
```

### **Expected Output:**
```sh
10
Hello, BASIC!
```

---

## 🎯 **Final Summary**
✔ **We wrote a lexer (`lexical.l`)** to tokenize BASIC code.  
✔ **We wrote a parser (`syntax.y`)** to convert tokens into C syntax.  
✔ **We compiled the parser and lexer** using `bison` and `flex`.  
✔ **We ran the compiler** to generate `output.c`.  
✔ **We compiled `output.c` with GCC** to produce an executable.  

🚀 **Congratulations! You just built a BASIC-to-C compiler!** 🚀

---

## 📌 **Next Steps**
🔹 Add support for `IF-THEN` statements  
🔹 Add loops (`FOR-NEXT`)  
🔹 Optimize code generation  

