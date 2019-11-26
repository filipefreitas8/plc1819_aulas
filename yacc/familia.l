%{
#include "familia.tab.h"
%}

%%
(?i:FAM)(?i:ILIA)? { return FAMILIA; }
":" { return ':'; }
[,\(\)] { return yytext[0]; }
\'[^']*\' { yytext[yyleng-1] = '\0'; yylval.texto = strdup(yytext + 1); return str; }
[a-zA-Z][a-zA-Z0-9|-|_]* { yylval.texto = strdup(yytext); return id; }
[0-9]{4}[./-][0-9]{2}[./-][0-9]{2} { return data; }
[0-9]+ { yylval.num = atoi(yytext); return inteiro; }
.|\n {;}
%%

int yywrap() {
	return 1;
}

