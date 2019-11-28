%{
#include "lpis.tab.h"
%}

%%
[:=;.] { return *yytext; }

"Inteiro" { return INTEIRO; }

[a-zA-Z][a-zA-Z0-9\-\_]* { yylval.texto = strdup(yytext); return id; }
(\+|\-)?[0-9]+ { yylval.numero = atoi(yytext); return num; }

[ \n\t] { ; }

. { return ERRO; }
%%

int yywrap() {
    return 1;
}
