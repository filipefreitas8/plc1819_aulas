%{
#include <stdio.h>
#include <stdlib.h>

#include "expbool.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9|-|_]* { yylval.texto = strdup(yytext); return id; }
[0-9]+(\.[0-9]+)? { yylval.vnum = atof(yytext); return num; }
[+\-*/|&=!()] { return yytext[0]; }
.|\n
%%

int yywrap() {
    return 1;
}


