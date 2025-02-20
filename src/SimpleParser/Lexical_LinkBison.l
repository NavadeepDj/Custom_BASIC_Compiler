%{
    #include "syntax.tab.h"  // Link with Bison
    #include <stdlib.h> // For atoi()
%}

/* Token patterns */
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

int yywrap() { return 1; }
