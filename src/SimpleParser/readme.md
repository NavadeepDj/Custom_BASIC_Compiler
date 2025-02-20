# Simple BASIC Parser using Flex & Bison

## Why Do We Need a Parser (Bison)?
The lexer (Flex) only breaks the input into tokens (words), but it does not verify if the sentence makes sense. A parser ensures that the tokens form a valid structure according to grammar rules.

### Analogy: English Grammar
- **Lexer (Flex):** Breaks a sentence into words.
  - Example: "The cat jumps"
  - Output: ("The", "cat", "jumps")
- **Parser (Bison):** Checks if the words form a valid sentence.
  - ? "The cat jumps"  Valid sentence
  - ? "Jumps cat The"  Invalid sentence (wrong order)

### In BASIC Programming
A parser (Bison) reads the tokens from the lexer and ensures they follow the syntax rules of BASIC.
- ? **LET X = 10** (Valid assignment)
- ? **LET = X 10** (Invalid syntax)
- ? **PRINT + 10** (Invalid print statement)

---

## Step-by-Step: Writing a Parser in Bison

### Step 1: Define Grammar Rules
BASIC supports:
- **Variable assignment**  `LET X = 10`
- **Print statement**  `PRINT X`

Grammar rules:
```
statement  LET IDENTIFIER = NUMBER
          | PRINT IDENTIFIER
```

### Step 2: Write a Parser (`syntax.y`)
This file defines the syntax rules and checks for valid statements.
```c
%{
    #include <stdio.h>
    void yyerror(const char *s);
    int yylex();
%}

/* Tokens from Flex */
%token LET PRINT IDENTIFIER NUMBER '='

%%

program:
    program statement '\n'
    | statement '\n'
    ;

statement:
    LET IDENTIFIER '=' NUMBER { printf("Valid Assignment\n"); }
    | PRINT IDENTIFIER { printf("Valid Print Statement\n"); }
    ;

%%

int main() {
    printf("Enter BASIC Code:\n");
    yyparse();  // Start parsing
    return 0;
}

void yyerror(const char *s) {
    printf("SYNTAX ERROR: %s\n", s);
}
```

---

### Step 3: Link Flex and Bison
Modify `lexical.l` to return tokens:
```c
%{
    #include "y.tab.h"  // Link with Bison
%}

%%
"LET"       { return LET; }
"PRINT"     { return PRINT; }
[A-Z]       { yylval = yytext[0]; return IDENTIFIER; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"="         { return '='; }
[ \t]       { /* Ignore spaces */ }
\n          { return '\n'; }
.           { printf("UNKNOWN TOKEN: %s\n", yytext); }

%%
```

---

## Step 4: Compile and Run
Open the terminal in the same folder as `syntax.y` and `lexical.l`, then run these commands:
```sh
bison -d syntax.y   # Generates parser files
flex lexical.l      # Generates lexer file
gcc syntax.tab.c lex.yy.c -o parser  # Compile both
./parser            # Run the parser
```

---

## Step 5: Test the Parser
### ? Valid Input:
```sh
LET X = 10
PRINT X
```
### ? Output:
```sh
Valid Assignment
Valid Print Statement
```

### ? Invalid Input:
```sh
LET = X 10
```
### ? Output:
```sh
SYNTAX ERROR: syntax error
```

---

## Summary
? **Lexer (Flex)**  Breaks input into tokens.
? **Parser (Bison)**  Checks if tokens follow the correct syntax.
? **If syntax is incorrect**  An error message is displayed.

This simple parser ensures that only valid BASIC statements are accepted, helping in further compilation or interpretation.


