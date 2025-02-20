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
