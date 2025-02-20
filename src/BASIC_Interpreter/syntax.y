/*Here we modify it to store the variable values in an array */
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex();  // Lexer function declaration

    // Symbol table to store variable values
    int symbolTable[26];  // 26 variables (A-Z)
%}

/* Token declarations from Flex */
%token LET PRINT IDENTIFIER NUMBER '='

%%

program:
    program statement '\n'
    | statement '\n'
    ;

statement:
    LET IDENTIFIER '=' NUMBER  { 
        symbolTable[$2 - 'A'] = $4;  
        printf("Stored: %c = %d\n", $2, $4);
    }
    | PRINT IDENTIFIER  { 
        printf("%c = %d\n", $2, symbolTable[$2 - 'A']);  
    }
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
