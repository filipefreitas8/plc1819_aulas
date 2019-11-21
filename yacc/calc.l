%{
#include <stdio.h>
#include <stdlib.h>

#include "calc.tab.h"
%}

%%
[ \t]

\n { return SEP; }
# { return FIM; }
"mem" { return MEM; }

[()+\-*/\^?!=] { return *yytext; }

(\+|\-)?[0-9]+ { yylval.num = atoi(yytext); return NUM; }

[a-z] { yylval.var = *yytext; return VAR; }

. { return ERRO; }
%%

int yywrap() {
    return 1;
}
