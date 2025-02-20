%{
    #include <stdio.h>
    void yyerror(const char *s);
    int yylex();  // Lexer function declaration
%}

/* Token declarations from Flex */
%token LET PRINT IDENTIFIER NUMBER '='

%%

program:
    program statement '\n'    // Multiple statements
    | statement '\n'          // Single statement
    ;

statement:
    LET IDENTIFIER '=' NUMBER { printf("Valid Assignment\n"); }
    | PRINT IDENTIFIER        { printf("Valid Print Statement\n"); }
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
